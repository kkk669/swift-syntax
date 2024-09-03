//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import SwiftSyntax

extension SyntaxProtocol {
  /// Produce a copy of this syntax node that removes all syntax regions that
  /// are inactive according to the given build configuration, leaving only
  /// the code that is active within that build configuration.
  ///
  /// If there are errors in the conditions of any configuration
  /// clauses, e.g., `#if FOO > 10`, then the condition will be
  /// considered to have failed and the clauses's elements will be
  /// removed.
  /// - Parameters:
  ///   - configuration: the configuration to apply.
  /// - Returns: the syntax node with all inactive regions removed, along with
  ///   an array containing any diagnostics produced along the way.
  public func removingInactive(
    in configuration: some BuildConfiguration
  ) -> (result: Syntax, diagnostics: [Diagnostic]) {
    return removingInactive(in: configuration, retainFeatureCheckIfConfigs: false)
  }

  /// Produce a copy of this syntax node that removes all syntax regions that
  /// are inactive according to the given build configuration, leaving only
  /// the code that is active within that build configuration.
  ///
  /// If there are errors in the conditions of any configuration
  /// clauses, e.g., `#if FOO > 10`, then the condition will be
  /// considered to have failed and the clauses's elements will be
  /// removed.
  /// - Parameters:
  ///   - configuration: the configuration to apply.
  ///   - retainFeatureCheckIfConfigs: whether to retain `#if` blocks involving
  ///     compiler version checks (e.g., `compiler(>=6.0)`) and `$`-based
  ///     feature checks.
  /// - Returns: the syntax node with all inactive regions removed, along with
  ///   an array containing any diagnostics produced along the way.
  @_spi(Compiler)
  public func removingInactive(
    in configuration: some BuildConfiguration,
    retainFeatureCheckIfConfigs: Bool
  ) -> (result: Syntax, diagnostics: [Diagnostic]) {
    // First pass: Find all of the active clauses for the #ifs we need to
    // visit, along with any diagnostics produced along the way. This process
    // does not change the tree in any way.
    let visitor = ActiveSyntaxVisitor(viewMode: .sourceAccurate, configuration: configuration)
    visitor.walk(self)

    // If there were no active clauses to visit, we're done!
    if !visitor.visitedAnyIfClauses {
      return (Syntax(self), visitor.diagnostics)
    }

    // Second pass: Rewrite the syntax tree by removing the inactive clauses
    // from each #if (along with the #ifs themselves).
    let rewriter = ActiveSyntaxRewriter(
      configuration: configuration,
      retainFeatureCheckIfConfigs: retainFeatureCheckIfConfigs
    )
    return (
      rewriter.rewrite(Syntax(self)),
      visitor.diagnostics
    )
  }
}

/// Syntax rewriter that only visits syntax nodes that are active according
/// to a particular build configuration.
///
/// Given an example such as
///
/// ```swift
/// #if os(Linux)
/// func f() { }
/// #elseif os(iOS)
/// func g() { }
/// #endif
/// ```
///
/// the rewriter will eliminate nodes for inactive clauses, leaving only
/// those nodes that are in active clauses. When rewriting the above given
/// a build configuration for Linux, the resulting tree will be
///
/// ```swift
/// func f() { }
/// ```
///
/// When rewriting the above given a build configuration for iOS, the resulting
/// tree will be
///
/// ```swift
/// func g() { }
/// ```
///
/// For any other target platforms, the resulting tree will be empty (other
/// than trivia).
class ActiveSyntaxRewriter<Configuration: BuildConfiguration>: SyntaxRewriter {
  let configuration: Configuration
  var diagnostics: [Diagnostic] = []

  /// Whether to retain `#if` blocks containing compiler and feature checks.
  var retainFeatureCheckIfConfigs: Bool

  init(configuration: Configuration, retainFeatureCheckIfConfigs: Bool) {
    self.configuration = configuration
    self.retainFeatureCheckIfConfigs = retainFeatureCheckIfConfigs
  }

  private func dropInactive<List: SyntaxCollection>(
    _ node: List,
    elementAsIfConfig: (List.Element) -> IfConfigDeclSyntax?
  ) -> List {
    var newElements: [List.Element] = []
    var anyChanged = false
    for elementIndex in node.indices {
      let element = node[elementIndex]

      // Find #ifs within the list.
      if let ifConfigDecl = elementAsIfConfig(element),
        (!retainFeatureCheckIfConfigs || !ifConfigDecl.containsFeatureCheck)
      {
        // Retrieve the active `#if` clause
        let (activeClause, localDiagnostics) = ifConfigDecl.activeClause(in: configuration)

        // Add these diagnostics.
        diagnostics.append(contentsOf: localDiagnostics)

        // If this is the first element that changed, note that we have
        // changes and add all prior elements to the list of new elements.
        if !anyChanged {
          anyChanged = true
          newElements.append(contentsOf: node[..<elementIndex])
        }

        // Extract the elements from the active clause, if there are any.
        guard let elements = activeClause?.elements else {
          continue
        }

        // In a well-formed syntax tree, the element list is always the
        // same type as List. However, handle a manually-constructed,
        // ill-formed syntax tree gracefully by dropping the inner elements
        // as well.
        if let innerElements = Syntax(elements).as(List.self) {
          let newInnerElements = dropInactive(innerElements, elementAsIfConfig: elementAsIfConfig)
          newElements.append(contentsOf: newInnerElements)
        }

        continue
      }

      if anyChanged {
        newElements.append(element)
      }
    }

    if !anyChanged {
      return node
    }

    return List(newElements)
  }

  override func visit(_ node: CodeBlockItemListSyntax) -> CodeBlockItemListSyntax {
    let rewrittenNode = dropInactive(node) { element in
      guard case .decl(let declElement) = element.item else {
        return nil
      }

      return declElement.as(IfConfigDeclSyntax.self)
    }

    return super.visit(rewrittenNode)
  }

  override func visit(_ node: MemberBlockItemListSyntax) -> MemberBlockItemListSyntax {
    let rewrittenNode = dropInactive(node) { element in
      return element.decl.as(IfConfigDeclSyntax.self)
    }

    return super.visit(rewrittenNode)
  }

  override func visit(_ node: SwitchCaseListSyntax) -> SwitchCaseListSyntax {
    let rewrittenNode = dropInactive(node) { element in
      if case .ifConfigDecl(let ifConfigDecl) = element {
        return ifConfigDecl
      }

      return nil
    }

    return super.visit(rewrittenNode)
  }

  override func visit(_ node: AttributeListSyntax) -> AttributeListSyntax {
    let rewrittenNode = dropInactive(node) { element in
      if case .ifConfigDecl(let ifConfigDecl) = element {
        return ifConfigDecl
      }

      return nil
    }

    return super.visit(rewrittenNode)
  }

  /// Apply the given base to the postfix expression.
  private func applyBaseToPostfixExpression(
    base: ExprSyntax,
    postfix: ExprSyntax
  ) -> ExprSyntax {
    /// Try to apply the base to the postfix expression using the given
    /// keypath into a specific node type.
    ///
    /// Returns the new expression node on success, `nil` when the node kind
    /// didn't match.
    func tryApply<Node: ExprSyntaxProtocol>(
      _ keyPath: WritableKeyPath<Node, ExprSyntax>
    ) -> ExprSyntax? {
      guard let node = postfix.as(Node.self) else {
        return nil
      }

      let newExpr = applyBaseToPostfixExpression(base: base, postfix: node[keyPath: keyPath])
      return ExprSyntax(node.with(keyPath, newExpr))
    }

    // Member access
    if let memberAccess = postfix.as(MemberAccessExprSyntax.self) {
      guard let memberBase = memberAccess.base else {
        // If this member access has no base, this is the base we are
        // replacing, terminating the recursion. Do so now.
        return ExprSyntax(memberAccess.with(\.base, base))
      }

      let newBase = applyBaseToPostfixExpression(base: base, postfix: memberBase)
      return ExprSyntax(memberAccess.with(\.base, newBase))
    }

    // Generic arguments <...>
    if let result = tryApply(\SpecializeExprSyntax.expression) {
      return result
    }

    // Call (...)
    if let result = tryApply(\FunctionCallExprSyntax.calledExpression) {
      return result
    }

    // Subscript [...]
    if let result = tryApply(\SubscriptExprSyntax.calledExpression) {
      return result
    }

    // Optional chaining ?
    if let result = tryApply(\OptionalChainingExprSyntax.expression) {
      return result
    }

    // Forced optional value !
    if let result = tryApply(\ForcedValueExprSyntax.expression) {
      return result
    }

    // Postfix unary operator.
    if let result = tryApply(\PostfixUnaryExprSyntax.expression) {
      return result
    }

    // #if
    if let postfixIfConfig = postfix.as(PostfixIfConfigExprSyntax.self) {
      return dropInactive(outerBase: base, postfixIfConfig: postfixIfConfig)
    }

    assertionFailure("Unhandled postfix expression in #if elimination")
    return postfix
  }

  /// Drop inactive regions from a postfix `#if` configuration, applying the
  /// outer "base" expression to the rewritten node.
  private func dropInactive(
    outerBase: ExprSyntax?,
    postfixIfConfig: PostfixIfConfigExprSyntax
  ) -> ExprSyntax {
    // If we're supposed to retain #if configs that are feature checks, and
    // this configuration has one, do so.
    if retainFeatureCheckIfConfigs && postfixIfConfig.config.containsFeatureCheck {
      return ExprSyntax(postfixIfConfig)
    }

    // Retrieve the active `if` clause.
    let (activeClause, localDiagnostics) = postfixIfConfig.config.activeClause(in: configuration)

    // Record these diagnostics.
    diagnostics.append(contentsOf: localDiagnostics)

    guard case .postfixExpression(let postfixExpr) = activeClause?.elements
    else {
      // If there is no active clause, return the base.

      // Prefer the base we have and, if not, use the outer base. We can
      // only have both in an ill-formed syntax tree that was manually
      // created.
      if let base = postfixIfConfig.base ?? outerBase {
        return base
      }

      // If there was no base, we're in an erroneous syntax tree that would
      // never be produced by the parser. Synthesize a missing expression
      // syntax node so clients can recover more gracefully.
      return ExprSyntax(
        MissingExprSyntax(
          placeholder: .init(.identifier("<#expression#>"), presence: .missing)
        )
      )
    }

    // If there is no base, return the postfix expression.
    guard let base = postfixIfConfig.base ?? outerBase else {
      return postfixExpr
    }

    // Apply the base to the postfix expression.
    return applyBaseToPostfixExpression(base: base, postfix: postfixExpr)
  }

  override func visit(_ node: PostfixIfConfigExprSyntax) -> ExprSyntax {
    let rewrittenNode = dropInactive(outerBase: nil, postfixIfConfig: node)
    if rewrittenNode == ExprSyntax(node) {
      return rewrittenNode
    }

    return visit(rewrittenNode)
  }
}

/// Helper class to find a feature or compiler check.
fileprivate class FindFeatureCheckVisitor: SyntaxVisitor {
  var foundFeatureCheck = false

  override func visit(_ node: DeclReferenceExprSyntax) -> SyntaxVisitorContinueKind {
    // Checks that start with $ are feature checks that should be retained.
    if let identifier = node.simpleIdentifier,
      let initialChar = identifier.name.first,
      initialChar == "$"
    {
      foundFeatureCheck = true
      return .skipChildren
    }

    return .visitChildren
  }

  override func visit(_ node: FunctionCallExprSyntax) -> SyntaxVisitorContinueKind {
    if let calleeDeclRef = node.calledExpression.as(DeclReferenceExprSyntax.self),
      let calleeName = calleeDeclRef.simpleIdentifier?.name,
      (calleeName == "compiler" || calleeName == "_compiler_version")
    {
      foundFeatureCheck = true
    }

    return .skipChildren
  }
}

extension ExprSyntaxProtocol {
  /// Whether any of the nodes in this expression involve compiler or feature
  /// checks.
  fileprivate var containsFeatureCheck: Bool {
    let visitor = FindFeatureCheckVisitor(viewMode: .fixedUp)
    visitor.walk(self)
    return visitor.foundFeatureCheck
  }
}

extension IfConfigDeclSyntax {
  /// Whether any of the clauses in this #if contain a feature check.
  var containsFeatureCheck: Bool {
    return clauses.contains { clause in
      if let condition = clause.condition {
        return condition.containsFeatureCheck
      } else {
        return false
      }
    }
  }
}

extension SyntaxProtocol {
  // Produce the source code for this syntax node with all of the comments
  // and #sourceLocations removed. Each comment will be replaced with either
  // a newline or a space, depending on whether the comment involved a newline.
  @_spi(Compiler)
  public var descriptionWithoutCommentsAndSourceLocations: String {
    var result = ""
    var skipUntilRParen = false
    for token in tokens(viewMode: .sourceAccurate) {
      // Skip #sourceLocation(...).
      if token.tokenKind == .poundSourceLocation {
        skipUntilRParen = true
        continue
      }

      if skipUntilRParen {
        if token.tokenKind == .rightParen {
          skipUntilRParen = false
        }
        continue
      }

      token.leadingTrivia.writeWithoutComments(to: &result)
      token.text.write(to: &result)
      token.trailingTrivia.writeWithoutComments(to: &result)
    }
    return result
  }
}

extension Trivia {
  fileprivate func writeWithoutComments(to stream: inout some TextOutputStream) {
    for piece in pieces {
      switch piece {
      case .backslashes, .carriageReturnLineFeeds, .carriageReturns, .formfeeds, .newlines, .pounds, .spaces, .tabs,
        .unexpectedText, .verticalTabs:
        piece.write(to: &stream)

      case .blockComment(let text), .docBlockComment(let text), .docLineComment(let text), .lineComment(let text):
        if text.contains(where: \.isNewline) {
          stream.write("\n")
        } else {
          stream.write(" ")
        }
      }
    }
  }
}
