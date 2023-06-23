//// Automatically generated by generate-swiftsyntax
//// Do not edit directly!
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

/// Enumerates the known kinds of Syntax represented in the Syntax tree.
public enum SyntaxKind: CaseIterable {
  case token
  case accessesEffect
  case accessorBlock
  case accessorDecl
  case accessorEffectSpecifiers
  case accessorInitEffects
  case accessorList
  case accessorParameter
  case actorDecl
  case arrayElementList
  case arrayElement
  case arrayExpr
  case arrayType
  case arrowExpr
  case asExpr
  case assignmentExpr
  case associatedtypeDecl
  case attributeList
  case attribute
  case attributedType
  case availabilityArgument
  case availabilityCondition
  case availabilityEntry
  case availabilityLabeledArgument
  case availabilitySpecList
  case availabilityVersionRestrictionListEntry
  case availabilityVersionRestrictionList
  case availabilityVersionRestriction
  case awaitExpr
  case backDeployedAttributeSpecList
  case binaryOperatorExpr
  case booleanLiteralExpr
  case borrowExpr
  case breakStmt
  case canImportExpr
  case canImportVersionInfo
  case caseItemList
  case caseItem
  case catchClauseList
  case catchClause
  case catchItemList
  case catchItem
  case classDecl
  case classRestrictionType
  case closureCaptureItemList
  case closureCaptureItemSpecifier
  case closureCaptureItem
  case closureCaptureSignature
  case closureExpr
  case closureParamList
  case closureParam
  case closureParameterClause
  case closureParameterList
  case closureParameter
  case closureSignature
  case codeBlockItemList
  case codeBlockItem
  case codeBlock
  case compositionTypeElementList
  case compositionTypeElement
  case compositionType
  case conditionElementList
  case conditionElement
  case conformanceRequirement
  case constrainedSugarType
  case continueStmt
  case conventionAttributeArguments
  case conventionWitnessMethodAttributeArguments
  case copyExpr
  case declModifierDetail
  case declModifier
  case declNameArgumentList
  case declNameArgument
  case declNameArguments
  case declName
  case deferStmt
  case deinitEffectSpecifiers
  case deinitializerDecl
  case derivativeRegistrationAttributeArguments
  case designatedTypeElement
  case designatedTypeList
  case dictionaryElementList
  case dictionaryElement
  case dictionaryExpr
  case dictionaryType
  case differentiabilityParamList
  case differentiabilityParam
  case differentiabilityParamsClause
  case differentiabilityParams
  case differentiableAttributeArguments
  case discardAssignmentExpr
  case discardStmt
  case doStmt
  case documentationAttributeArgument
  case documentationAttributeArguments
  case dynamicReplacementArguments
  case editorPlaceholderDecl
  case editorPlaceholderExpr
  case effectsArguments
  case enumCaseDecl
  case enumCaseElementList
  case enumCaseElement
  case enumCaseParameterClause
  case enumCaseParameterList
  case enumCaseParameter
  case enumDecl
  case exposeAttributeArguments
  case exprList
  case expressionPattern
  case expressionSegment
  case expressionStmt
  case extensionDecl
  case fallthroughStmt
  case floatLiteralExpr
  case forInStmt
  case forcedValueExpr
  case functionCallExpr
  case functionDecl
  case functionEffectSpecifiers
  case functionParameterList
  case functionParameter
  case functionSignature
  case functionType
  case genericArgumentClause
  case genericArgumentList
  case genericArgument
  case genericParameterClause
  case genericParameterList
  case genericParameter
  case genericRequirementList
  case genericRequirement
  case genericWhereClause
  case guardStmt
  case identifierExpr
  case identifierPattern
  case ifConfigClauseList
  case ifConfigClause
  case ifConfigDecl
  case ifExpr
  case implementsAttributeArguments
  case implicitlyUnwrappedOptionalType
  case importDecl
  case importPathComponent
  case importPath
  case inOutExpr
  case infixOperatorExpr
  case inheritedTypeList
  case inheritedType
  case initializerClause
  case initializerDecl
  case initializesEffect
  case integerLiteralExpr
  case isExpr
  case isTypePattern
  case keyPathComponentList
  case keyPathComponent
  case keyPathExpr
  case keyPathOptionalComponent
  case keyPathPropertyComponent
  case keyPathSubscriptComponent
  case labeledSpecializeEntry
  case labeledStmt
  case layoutRequirement
  case macroDecl
  case macroExpansionDecl
  case macroExpansionExpr
  case matchingPatternCondition
  case memberAccessExpr
  case memberDeclBlock
  case memberDeclListItem
  case memberDeclList
  case memberTypeIdentifier
  case metatypeType
  case missingDecl
  case missingExpr
  case missingPattern
  case missingStmt
  case missing
  case missingType
  case modifierList
  case moveExpr
  case multipleTrailingClosureElementList
  case multipleTrailingClosureElement
  case namedOpaqueReturnType
  case nilLiteralExpr
  case objCSelectorPiece
  case objCSelector
  case opaqueReturnTypeOfAttributeArguments
  case operatorDecl
  case operatorPrecedenceAndTypes
  case optionalBindingCondition
  case optionalChainingExpr
  case optionalType
  case originallyDefinedInArguments
  case packElementExpr
  case packExpansionExpr
  case packExpansionType
  case packReferenceType
  case parameterClause
  case patternBindingList
  case patternBinding
  case postfixIfConfigExpr
  case postfixUnaryExpr
  case poundSourceLocationArgs
  case poundSourceLocation
  case precedenceGroupAssignment
  case precedenceGroupAssociativity
  case precedenceGroupAttributeList
  case precedenceGroupDecl
  case precedenceGroupNameElement
  case precedenceGroupNameList
  case precedenceGroupRelation
  case prefixOperatorExpr
  case primaryAssociatedTypeClause
  case primaryAssociatedTypeList
  case primaryAssociatedType
  case protocolDecl
  case qualifiedDeclName
  case regexLiteralExpr
  case repeatWhileStmt
  case returnClause
  case returnStmt
  case sameTypeRequirement
  case sequenceExpr
  case simpleTypeIdentifier
  case sourceFile
  case specializeAttributeSpecList
  case specializeExpr
  case stringLiteralExpr
  case stringLiteralSegments
  case stringSegment
  case structDecl
  case subscriptDecl
  case subscriptExpr
  case superRefExpr
  case suppressedType
  case switchCaseLabel
  case switchCaseList
  case switchCase
  case switchDefaultLabel
  case switchExpr
  case targetFunctionEntry
  case ternaryExpr
  case throwStmt
  case tryExpr
  case tupleExprElementList
  case tupleExprElement
  case tupleExpr
  case tuplePatternElementList
  case tuplePatternElement
  case tuplePattern
  case tupleTypeElementList
  case tupleTypeElement
  case tupleType
  case typeAnnotation
  case typeEffectSpecifiers
  case typeExpr
  case typeInheritanceClause
  case typeInitializerClause
  case typealiasDecl
  case unavailableFromAsyncArguments
  case underscorePrivateAttributeArguments
  case unexpectedNodes
  case unresolvedAsExpr
  case unresolvedIsExpr
  case unresolvedPatternExpr
  case unresolvedTernaryExpr
  case valueBindingPattern
  case variableDecl
  case versionComponentList
  case versionComponent
  case versionTuple
  case whereClause
  case whileStmt
  case wildcardPattern
  case yieldExprListElement
  case yieldExprList
  case yieldList
  case yieldStmt
  
  public var isSyntaxCollection: Bool {
    switch self {
    case .accessorList:
      return true
    case .arrayElementList:
      return true
    case .attributeList:
      return true
    case .availabilitySpecList:
      return true
    case .availabilityVersionRestrictionList:
      return true
    case .caseItemList:
      return true
    case .catchClauseList:
      return true
    case .catchItemList:
      return true
    case .closureCaptureItemList:
      return true
    case .closureParamList:
      return true
    case .closureParameterList:
      return true
    case .codeBlockItemList:
      return true
    case .compositionTypeElementList:
      return true
    case .conditionElementList:
      return true
    case .declNameArgumentList:
      return true
    case .designatedTypeList:
      return true
    case .dictionaryElementList:
      return true
    case .differentiabilityParamList:
      return true
    case .documentationAttributeArguments:
      return true
    case .effectsArguments:
      return true
    case .enumCaseElementList:
      return true
    case .enumCaseParameterList:
      return true
    case .exprList:
      return true
    case .functionParameterList:
      return true
    case .genericArgumentList:
      return true
    case .genericParameterList:
      return true
    case .genericRequirementList:
      return true
    case .ifConfigClauseList:
      return true
    case .importPath:
      return true
    case .inheritedTypeList:
      return true
    case .keyPathComponentList:
      return true
    case .memberDeclList:
      return true
    case .modifierList:
      return true
    case .multipleTrailingClosureElementList:
      return true
    case .objCSelector:
      return true
    case .patternBindingList:
      return true
    case .precedenceGroupAttributeList:
      return true
    case .precedenceGroupNameList:
      return true
    case .primaryAssociatedTypeList:
      return true
    case .specializeAttributeSpecList:
      return true
    case .stringLiteralSegments:
      return true
    case .switchCaseList:
      return true
    case .tupleExprElementList:
      return true
    case .tuplePatternElementList:
      return true
    case .tupleTypeElementList:
      return true
    case .unexpectedNodes:
      return true
    case .versionComponentList:
      return true
    case .yieldExprList:
      return true
    default:
      return false
    }
  }
  
  public var isMissing: Bool {
    switch self {
    case .missingDecl:
      return true
    case .missingExpr:
      return true
    case .missingPattern:
      return true
    case .missingStmt:
      return true
    case .missing:
      return true
    case .missingType:
      return true
    default:
      return false
    }
  }
  
  public var syntaxNodeType: SyntaxProtocol.Type {
    switch self {
    case .token:
      return TokenSyntax.self
    case .accessesEffect:
      return AccessesEffectSyntax.self
    case .accessorBlock:
      return AccessorBlockSyntax.self
    case .accessorDecl:
      return AccessorDeclSyntax.self
    case .accessorEffectSpecifiers:
      return AccessorEffectSpecifiersSyntax.self
    case .accessorInitEffects:
      return AccessorInitEffectsSyntax.self
    case .accessorList:
      return AccessorListSyntax.self
    case .accessorParameter:
      return AccessorParameterSyntax.self
    case .actorDecl:
      return ActorDeclSyntax.self
    case .arrayElementList:
      return ArrayElementListSyntax.self
    case .arrayElement:
      return ArrayElementSyntax.self
    case .arrayExpr:
      return ArrayExprSyntax.self
    case .arrayType:
      return ArrayTypeSyntax.self
    case .arrowExpr:
      return ArrowExprSyntax.self
    case .asExpr:
      return AsExprSyntax.self
    case .assignmentExpr:
      return AssignmentExprSyntax.self
    case .associatedtypeDecl:
      return AssociatedtypeDeclSyntax.self
    case .attributeList:
      return AttributeListSyntax.self
    case .attribute:
      return AttributeSyntax.self
    case .attributedType:
      return AttributedTypeSyntax.self
    case .availabilityArgument:
      return AvailabilityArgumentSyntax.self
    case .availabilityCondition:
      return AvailabilityConditionSyntax.self
    case .availabilityEntry:
      return AvailabilityEntrySyntax.self
    case .availabilityLabeledArgument:
      return AvailabilityLabeledArgumentSyntax.self
    case .availabilitySpecList:
      return AvailabilitySpecListSyntax.self
    case .availabilityVersionRestrictionListEntry:
      return AvailabilityVersionRestrictionListEntrySyntax.self
    case .availabilityVersionRestrictionList:
      return AvailabilityVersionRestrictionListSyntax.self
    case .availabilityVersionRestriction:
      return AvailabilityVersionRestrictionSyntax.self
    case .awaitExpr:
      return AwaitExprSyntax.self
    case .backDeployedAttributeSpecList:
      return BackDeployedAttributeSpecListSyntax.self
    case .binaryOperatorExpr:
      return BinaryOperatorExprSyntax.self
    case .booleanLiteralExpr:
      return BooleanLiteralExprSyntax.self
    case .borrowExpr:
      return BorrowExprSyntax.self
    case .breakStmt:
      return BreakStmtSyntax.self
    case .canImportExpr:
      return CanImportExprSyntax.self
    case .canImportVersionInfo:
      return CanImportVersionInfoSyntax.self
    case .caseItemList:
      return CaseItemListSyntax.self
    case .caseItem:
      return CaseItemSyntax.self
    case .catchClauseList:
      return CatchClauseListSyntax.self
    case .catchClause:
      return CatchClauseSyntax.self
    case .catchItemList:
      return CatchItemListSyntax.self
    case .catchItem:
      return CatchItemSyntax.self
    case .classDecl:
      return ClassDeclSyntax.self
    case .classRestrictionType:
      return ClassRestrictionTypeSyntax.self
    case .closureCaptureItemList:
      return ClosureCaptureItemListSyntax.self
    case .closureCaptureItemSpecifier:
      return ClosureCaptureItemSpecifierSyntax.self
    case .closureCaptureItem:
      return ClosureCaptureItemSyntax.self
    case .closureCaptureSignature:
      return ClosureCaptureSignatureSyntax.self
    case .closureExpr:
      return ClosureExprSyntax.self
    case .closureParamList:
      return ClosureParamListSyntax.self
    case .closureParam:
      return ClosureParamSyntax.self
    case .closureParameterClause:
      return ClosureParameterClauseSyntax.self
    case .closureParameterList:
      return ClosureParameterListSyntax.self
    case .closureParameter:
      return ClosureParameterSyntax.self
    case .closureSignature:
      return ClosureSignatureSyntax.self
    case .codeBlockItemList:
      return CodeBlockItemListSyntax.self
    case .codeBlockItem:
      return CodeBlockItemSyntax.self
    case .codeBlock:
      return CodeBlockSyntax.self
    case .compositionTypeElementList:
      return CompositionTypeElementListSyntax.self
    case .compositionTypeElement:
      return CompositionTypeElementSyntax.self
    case .compositionType:
      return CompositionTypeSyntax.self
    case .conditionElementList:
      return ConditionElementListSyntax.self
    case .conditionElement:
      return ConditionElementSyntax.self
    case .conformanceRequirement:
      return ConformanceRequirementSyntax.self
    case .constrainedSugarType:
      return ConstrainedSugarTypeSyntax.self
    case .continueStmt:
      return ContinueStmtSyntax.self
    case .conventionAttributeArguments:
      return ConventionAttributeArgumentsSyntax.self
    case .conventionWitnessMethodAttributeArguments:
      return ConventionWitnessMethodAttributeArgumentsSyntax.self
    case .copyExpr:
      return CopyExprSyntax.self
    case .declModifierDetail:
      return DeclModifierDetailSyntax.self
    case .declModifier:
      return DeclModifierSyntax.self
    case .declNameArgumentList:
      return DeclNameArgumentListSyntax.self
    case .declNameArgument:
      return DeclNameArgumentSyntax.self
    case .declNameArguments:
      return DeclNameArgumentsSyntax.self
    case .declName:
      return DeclNameSyntax.self
    case .deferStmt:
      return DeferStmtSyntax.self
    case .deinitEffectSpecifiers:
      return DeinitEffectSpecifiersSyntax.self
    case .deinitializerDecl:
      return DeinitializerDeclSyntax.self
    case .derivativeRegistrationAttributeArguments:
      return DerivativeRegistrationAttributeArgumentsSyntax.self
    case .designatedTypeElement:
      return DesignatedTypeElementSyntax.self
    case .designatedTypeList:
      return DesignatedTypeListSyntax.self
    case .dictionaryElementList:
      return DictionaryElementListSyntax.self
    case .dictionaryElement:
      return DictionaryElementSyntax.self
    case .dictionaryExpr:
      return DictionaryExprSyntax.self
    case .dictionaryType:
      return DictionaryTypeSyntax.self
    case .differentiabilityParamList:
      return DifferentiabilityParamListSyntax.self
    case .differentiabilityParam:
      return DifferentiabilityParamSyntax.self
    case .differentiabilityParamsClause:
      return DifferentiabilityParamsClauseSyntax.self
    case .differentiabilityParams:
      return DifferentiabilityParamsSyntax.self
    case .differentiableAttributeArguments:
      return DifferentiableAttributeArgumentsSyntax.self
    case .discardAssignmentExpr:
      return DiscardAssignmentExprSyntax.self
    case .discardStmt:
      return DiscardStmtSyntax.self
    case .doStmt:
      return DoStmtSyntax.self
    case .documentationAttributeArgument:
      return DocumentationAttributeArgumentSyntax.self
    case .documentationAttributeArguments:
      return DocumentationAttributeArgumentsSyntax.self
    case .dynamicReplacementArguments:
      return DynamicReplacementArgumentsSyntax.self
    case .editorPlaceholderDecl:
      return EditorPlaceholderDeclSyntax.self
    case .editorPlaceholderExpr:
      return EditorPlaceholderExprSyntax.self
    case .effectsArguments:
      return EffectsArgumentsSyntax.self
    case .enumCaseDecl:
      return EnumCaseDeclSyntax.self
    case .enumCaseElementList:
      return EnumCaseElementListSyntax.self
    case .enumCaseElement:
      return EnumCaseElementSyntax.self
    case .enumCaseParameterClause:
      return EnumCaseParameterClauseSyntax.self
    case .enumCaseParameterList:
      return EnumCaseParameterListSyntax.self
    case .enumCaseParameter:
      return EnumCaseParameterSyntax.self
    case .enumDecl:
      return EnumDeclSyntax.self
    case .exposeAttributeArguments:
      return ExposeAttributeArgumentsSyntax.self
    case .exprList:
      return ExprListSyntax.self
    case .expressionPattern:
      return ExpressionPatternSyntax.self
    case .expressionSegment:
      return ExpressionSegmentSyntax.self
    case .expressionStmt:
      return ExpressionStmtSyntax.self
    case .extensionDecl:
      return ExtensionDeclSyntax.self
    case .fallthroughStmt:
      return FallthroughStmtSyntax.self
    case .floatLiteralExpr:
      return FloatLiteralExprSyntax.self
    case .forInStmt:
      return ForInStmtSyntax.self
    case .forcedValueExpr:
      return ForcedValueExprSyntax.self
    case .functionCallExpr:
      return FunctionCallExprSyntax.self
    case .functionDecl:
      return FunctionDeclSyntax.self
    case .functionEffectSpecifiers:
      return FunctionEffectSpecifiersSyntax.self
    case .functionParameterList:
      return FunctionParameterListSyntax.self
    case .functionParameter:
      return FunctionParameterSyntax.self
    case .functionSignature:
      return FunctionSignatureSyntax.self
    case .functionType:
      return FunctionTypeSyntax.self
    case .genericArgumentClause:
      return GenericArgumentClauseSyntax.self
    case .genericArgumentList:
      return GenericArgumentListSyntax.self
    case .genericArgument:
      return GenericArgumentSyntax.self
    case .genericParameterClause:
      return GenericParameterClauseSyntax.self
    case .genericParameterList:
      return GenericParameterListSyntax.self
    case .genericParameter:
      return GenericParameterSyntax.self
    case .genericRequirementList:
      return GenericRequirementListSyntax.self
    case .genericRequirement:
      return GenericRequirementSyntax.self
    case .genericWhereClause:
      return GenericWhereClauseSyntax.self
    case .guardStmt:
      return GuardStmtSyntax.self
    case .identifierExpr:
      return IdentifierExprSyntax.self
    case .identifierPattern:
      return IdentifierPatternSyntax.self
    case .ifConfigClauseList:
      return IfConfigClauseListSyntax.self
    case .ifConfigClause:
      return IfConfigClauseSyntax.self
    case .ifConfigDecl:
      return IfConfigDeclSyntax.self
    case .ifExpr:
      return IfExprSyntax.self
    case .implementsAttributeArguments:
      return ImplementsAttributeArgumentsSyntax.self
    case .implicitlyUnwrappedOptionalType:
      return ImplicitlyUnwrappedOptionalTypeSyntax.self
    case .importDecl:
      return ImportDeclSyntax.self
    case .importPathComponent:
      return ImportPathComponentSyntax.self
    case .importPath:
      return ImportPathSyntax.self
    case .inOutExpr:
      return InOutExprSyntax.self
    case .infixOperatorExpr:
      return InfixOperatorExprSyntax.self
    case .inheritedTypeList:
      return InheritedTypeListSyntax.self
    case .inheritedType:
      return InheritedTypeSyntax.self
    case .initializerClause:
      return InitializerClauseSyntax.self
    case .initializerDecl:
      return InitializerDeclSyntax.self
    case .initializesEffect:
      return InitializesEffectSyntax.self
    case .integerLiteralExpr:
      return IntegerLiteralExprSyntax.self
    case .isExpr:
      return IsExprSyntax.self
    case .isTypePattern:
      return IsTypePatternSyntax.self
    case .keyPathComponentList:
      return KeyPathComponentListSyntax.self
    case .keyPathComponent:
      return KeyPathComponentSyntax.self
    case .keyPathExpr:
      return KeyPathExprSyntax.self
    case .keyPathOptionalComponent:
      return KeyPathOptionalComponentSyntax.self
    case .keyPathPropertyComponent:
      return KeyPathPropertyComponentSyntax.self
    case .keyPathSubscriptComponent:
      return KeyPathSubscriptComponentSyntax.self
    case .labeledSpecializeEntry:
      return LabeledSpecializeEntrySyntax.self
    case .labeledStmt:
      return LabeledStmtSyntax.self
    case .layoutRequirement:
      return LayoutRequirementSyntax.self
    case .macroDecl:
      return MacroDeclSyntax.self
    case .macroExpansionDecl:
      return MacroExpansionDeclSyntax.self
    case .macroExpansionExpr:
      return MacroExpansionExprSyntax.self
    case .matchingPatternCondition:
      return MatchingPatternConditionSyntax.self
    case .memberAccessExpr:
      return MemberAccessExprSyntax.self
    case .memberDeclBlock:
      return MemberDeclBlockSyntax.self
    case .memberDeclListItem:
      return MemberDeclListItemSyntax.self
    case .memberDeclList:
      return MemberDeclListSyntax.self
    case .memberTypeIdentifier:
      return MemberTypeIdentifierSyntax.self
    case .metatypeType:
      return MetatypeTypeSyntax.self
    case .missingDecl:
      return MissingDeclSyntax.self
    case .missingExpr:
      return MissingExprSyntax.self
    case .missingPattern:
      return MissingPatternSyntax.self
    case .missingStmt:
      return MissingStmtSyntax.self
    case .missing:
      return MissingSyntax.self
    case .missingType:
      return MissingTypeSyntax.self
    case .modifierList:
      return ModifierListSyntax.self
    case .moveExpr:
      return MoveExprSyntax.self
    case .multipleTrailingClosureElementList:
      return MultipleTrailingClosureElementListSyntax.self
    case .multipleTrailingClosureElement:
      return MultipleTrailingClosureElementSyntax.self
    case .namedOpaqueReturnType:
      return NamedOpaqueReturnTypeSyntax.self
    case .nilLiteralExpr:
      return NilLiteralExprSyntax.self
    case .objCSelectorPiece:
      return ObjCSelectorPieceSyntax.self
    case .objCSelector:
      return ObjCSelectorSyntax.self
    case .opaqueReturnTypeOfAttributeArguments:
      return OpaqueReturnTypeOfAttributeArgumentsSyntax.self
    case .operatorDecl:
      return OperatorDeclSyntax.self
    case .operatorPrecedenceAndTypes:
      return OperatorPrecedenceAndTypesSyntax.self
    case .optionalBindingCondition:
      return OptionalBindingConditionSyntax.self
    case .optionalChainingExpr:
      return OptionalChainingExprSyntax.self
    case .optionalType:
      return OptionalTypeSyntax.self
    case .originallyDefinedInArguments:
      return OriginallyDefinedInArgumentsSyntax.self
    case .packElementExpr:
      return PackElementExprSyntax.self
    case .packExpansionExpr:
      return PackExpansionExprSyntax.self
    case .packExpansionType:
      return PackExpansionTypeSyntax.self
    case .packReferenceType:
      return PackReferenceTypeSyntax.self
    case .parameterClause:
      return ParameterClauseSyntax.self
    case .patternBindingList:
      return PatternBindingListSyntax.self
    case .patternBinding:
      return PatternBindingSyntax.self
    case .postfixIfConfigExpr:
      return PostfixIfConfigExprSyntax.self
    case .postfixUnaryExpr:
      return PostfixUnaryExprSyntax.self
    case .poundSourceLocationArgs:
      return PoundSourceLocationArgsSyntax.self
    case .poundSourceLocation:
      return PoundSourceLocationSyntax.self
    case .precedenceGroupAssignment:
      return PrecedenceGroupAssignmentSyntax.self
    case .precedenceGroupAssociativity:
      return PrecedenceGroupAssociativitySyntax.self
    case .precedenceGroupAttributeList:
      return PrecedenceGroupAttributeListSyntax.self
    case .precedenceGroupDecl:
      return PrecedenceGroupDeclSyntax.self
    case .precedenceGroupNameElement:
      return PrecedenceGroupNameElementSyntax.self
    case .precedenceGroupNameList:
      return PrecedenceGroupNameListSyntax.self
    case .precedenceGroupRelation:
      return PrecedenceGroupRelationSyntax.self
    case .prefixOperatorExpr:
      return PrefixOperatorExprSyntax.self
    case .primaryAssociatedTypeClause:
      return PrimaryAssociatedTypeClauseSyntax.self
    case .primaryAssociatedTypeList:
      return PrimaryAssociatedTypeListSyntax.self
    case .primaryAssociatedType:
      return PrimaryAssociatedTypeSyntax.self
    case .protocolDecl:
      return ProtocolDeclSyntax.self
    case .qualifiedDeclName:
      return QualifiedDeclNameSyntax.self
    case .regexLiteralExpr:
      return RegexLiteralExprSyntax.self
    case .repeatWhileStmt:
      return RepeatWhileStmtSyntax.self
    case .returnClause:
      return ReturnClauseSyntax.self
    case .returnStmt:
      return ReturnStmtSyntax.self
    case .sameTypeRequirement:
      return SameTypeRequirementSyntax.self
    case .sequenceExpr:
      return SequenceExprSyntax.self
    case .simpleTypeIdentifier:
      return SimpleTypeIdentifierSyntax.self
    case .sourceFile:
      return SourceFileSyntax.self
    case .specializeAttributeSpecList:
      return SpecializeAttributeSpecListSyntax.self
    case .specializeExpr:
      return SpecializeExprSyntax.self
    case .stringLiteralExpr:
      return StringLiteralExprSyntax.self
    case .stringLiteralSegments:
      return StringLiteralSegmentsSyntax.self
    case .stringSegment:
      return StringSegmentSyntax.self
    case .structDecl:
      return StructDeclSyntax.self
    case .subscriptDecl:
      return SubscriptDeclSyntax.self
    case .subscriptExpr:
      return SubscriptExprSyntax.self
    case .superRefExpr:
      return SuperRefExprSyntax.self
    case .suppressedType:
      return SuppressedTypeSyntax.self
    case .switchCaseLabel:
      return SwitchCaseLabelSyntax.self
    case .switchCaseList:
      return SwitchCaseListSyntax.self
    case .switchCase:
      return SwitchCaseSyntax.self
    case .switchDefaultLabel:
      return SwitchDefaultLabelSyntax.self
    case .switchExpr:
      return SwitchExprSyntax.self
    case .targetFunctionEntry:
      return TargetFunctionEntrySyntax.self
    case .ternaryExpr:
      return TernaryExprSyntax.self
    case .throwStmt:
      return ThrowStmtSyntax.self
    case .tryExpr:
      return TryExprSyntax.self
    case .tupleExprElementList:
      return TupleExprElementListSyntax.self
    case .tupleExprElement:
      return TupleExprElementSyntax.self
    case .tupleExpr:
      return TupleExprSyntax.self
    case .tuplePatternElementList:
      return TuplePatternElementListSyntax.self
    case .tuplePatternElement:
      return TuplePatternElementSyntax.self
    case .tuplePattern:
      return TuplePatternSyntax.self
    case .tupleTypeElementList:
      return TupleTypeElementListSyntax.self
    case .tupleTypeElement:
      return TupleTypeElementSyntax.self
    case .tupleType:
      return TupleTypeSyntax.self
    case .typeAnnotation:
      return TypeAnnotationSyntax.self
    case .typeEffectSpecifiers:
      return TypeEffectSpecifiersSyntax.self
    case .typeExpr:
      return TypeExprSyntax.self
    case .typeInheritanceClause:
      return TypeInheritanceClauseSyntax.self
    case .typeInitializerClause:
      return TypeInitializerClauseSyntax.self
    case .typealiasDecl:
      return TypealiasDeclSyntax.self
    case .unavailableFromAsyncArguments:
      return UnavailableFromAsyncArgumentsSyntax.self
    case .underscorePrivateAttributeArguments:
      return UnderscorePrivateAttributeArgumentsSyntax.self
    case .unexpectedNodes:
      return UnexpectedNodesSyntax.self
    case .unresolvedAsExpr:
      return UnresolvedAsExprSyntax.self
    case .unresolvedIsExpr:
      return UnresolvedIsExprSyntax.self
    case .unresolvedPatternExpr:
      return UnresolvedPatternExprSyntax.self
    case .unresolvedTernaryExpr:
      return UnresolvedTernaryExprSyntax.self
    case .valueBindingPattern:
      return ValueBindingPatternSyntax.self
    case .variableDecl:
      return VariableDeclSyntax.self
    case .versionComponentList:
      return VersionComponentListSyntax.self
    case .versionComponent:
      return VersionComponentSyntax.self
    case .versionTuple:
      return VersionTupleSyntax.self
    case .whereClause:
      return WhereClauseSyntax.self
    case .whileStmt:
      return WhileStmtSyntax.self
    case .wildcardPattern:
      return WildcardPatternSyntax.self
    case .yieldExprListElement:
      return YieldExprListElementSyntax.self
    case .yieldExprList:
      return YieldExprListSyntax.self
    case .yieldList:
      return YieldListSyntax.self
    case .yieldStmt:
      return YieldStmtSyntax.self
    }
  }
}
