// swift-tools-version:5.5

import PackageDescription
import Foundation

/// If we are in a controlled CI environment, we can use internal compiler flags
/// to speed up the build or improve it.
let swiftSyntaxSwiftSettings: [SwiftSetting]
if ProcessInfo.processInfo.environment["SWIFT_BUILD_SCRIPT_ENVIRONMENT"] != nil {
  let groupFile = URL(fileURLWithPath: #file)
    .deletingLastPathComponent()
    .appendingPathComponent("utils")
    .appendingPathComponent("group.json")
  swiftSyntaxSwiftSettings = [
    .define("SWIFTSYNTAX_ENABLE_ASSERTIONS"),
    .unsafeFlags([
      "-Xfrontend", "-group-info-path",
      "-Xfrontend", groupFile.path,
      // Enforcing exclusivity increases compile time of release builds by 2 minutes.
      // Disable it when we're in a controlled CI environment.
      "-enforce-exclusivity=unchecked",
    ]),
  ]
} else {
  swiftSyntaxSwiftSettings = []
}

let package = Package(
  name: "SwiftSyntax",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
    .watchOS(.v6),
    .macCatalyst(.v13),
  ],
  products: [
    .library(name: "IDEUtils", targets: ["IDEUtils"]),
    .library(name: "SwiftDiagnostics", targets: ["SwiftDiagnostics"]),
    .library(name: "SwiftOperators", targets: ["SwiftOperators"]),
    .library(name: "SwiftParser", targets: ["SwiftParser"]),
    .library(name: "SwiftParserDiagnostics", targets: ["SwiftParserDiagnostics"]),
    .library(name: "SwiftSyntax", targets: ["SwiftSyntax"]),
    .library(name: "SwiftSyntaxParser", targets: ["SwiftSyntaxParser"]),
    .library(name: "SwiftSyntaxBuilder", targets: ["SwiftSyntaxBuilder"]),
    .library(name: "SwiftSyntaxMacros", targets: ["SwiftSyntaxMacros"]),
    .library(name: "SwiftCompilerPlugin", targets: ["SwiftCompilerPlugin"]),
    .library(name: "SwiftCompilerPluginMessageHandling", targets: ["SwiftCompilerPluginMessageHandling"]),
    .library(name: "SwiftRefactor", targets: ["SwiftRefactor"]),
  ],
  targets: [
    .target(
      name: "SwiftBasicFormat",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "CMakeLists.txt"
      ]
    ),
    .target(
      name: "SwiftDiagnostics",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "CMakeLists.txt"
      ]
    ),
    .target(
      name: "SwiftSyntax",
      dependencies: [],
      exclude: [
        "CMakeLists.txt"
      ],
      swiftSettings: swiftSyntaxSwiftSettings
    ),
    .target(
      name: "SwiftSyntaxBuilder",
      dependencies: ["SwiftBasicFormat", "SwiftSyntax", "SwiftParser", "SwiftParserDiagnostics"],
      exclude: [
        "CMakeLists.txt"
      ]
    ),
    .target(
      name: "SwiftSyntaxParser",
      dependencies: ["SwiftSyntax", "SwiftParser",
                     .target(name: "WASIHelpers", condition: .when(platforms: [.wasi]))]
    ),
    .target(
      name: "_SwiftSyntaxTestSupport",
      dependencies: ["SwiftBasicFormat", "SwiftSyntax", "SwiftSyntaxBuilder"]
    ),
    .target(
      name: "IDEUtils",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "CMakeLists.txt"
      ]
    ),
    .target(
      name: "SwiftParser",
      dependencies: ["SwiftSyntax"],
      exclude: [
        "CMakeLists.txt",
        "README.md",
      ]
    ),
    .target(
      name: "SwiftParserDiagnostics",
      dependencies: ["SwiftBasicFormat", "SwiftDiagnostics", "SwiftParser", "SwiftSyntax"],
      exclude: [
        "CMakeLists.txt"
      ]
    ),
    .target(
      name: "SwiftOperators",
      dependencies: ["SwiftSyntax", "SwiftParser", "SwiftDiagnostics"],
      exclude: [
        "CMakeLists.txt"
      ]
    ),
    .target(
      name: "SwiftSyntaxMacros",
      dependencies: [
        "SwiftSyntax", "SwiftSyntaxBuilder", "SwiftParser", "SwiftDiagnostics",
      ],
      exclude: [
        "CMakeLists.txt"
      ]
    ),
    .target(
      name: "SwiftCompilerPlugin",
      dependencies: [
        "SwiftCompilerPluginMessageHandling", "SwiftSyntaxMacros",
      ]
    ),
    .target(
      name: "SwiftCompilerPluginMessageHandling",
      dependencies: [
        "SwiftSyntax", "SwiftParser", "SwiftDiagnostics", "SwiftSyntaxMacros", "SwiftOperators",
      ],
      exclude: [
        "CMakeLists.txt"
      ]
    ),
    .target(
      name: "SwiftRefactor",
      dependencies: [
        "SwiftSyntax", "SwiftParser",
      ]
    ),
    .target(
      name: "WASIHelpers"
    ),
    .executableTarget(
      name: "lit-test-helper",
      dependencies: ["IDEUtils", "SwiftSyntax", "SwiftSyntaxParser"]
    ),
    .testTarget(name: "IDEUtilsTest", dependencies: ["_SwiftSyntaxTestSupport", "SwiftParser", "SwiftSyntax", "IDEUtils"]),
    .testTarget(
      name: "SwiftDiagnosticsTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftDiagnostics", "SwiftParser", "SwiftParserDiagnostics"]
    ),
    .testTarget(
      name: "SwiftSyntaxTest",
      dependencies: ["SwiftSyntax", "_SwiftSyntaxTestSupport"]
    ),
    .testTarget(
      name: "SwiftSyntaxBuilderTest",
      dependencies: ["_SwiftSyntaxTestSupport", "SwiftSyntaxBuilder"]
    ),
    .testTarget(
      name: "SwiftSyntaxParserTest",
      dependencies: ["SwiftSyntaxParser", "_SwiftSyntaxTestSupport",
                     .target(name: "WASIHelpers", condition: .when(platforms: [.wasi]))],
      exclude: ["Inputs"]
    ),
    .testTarget(
      name: "SwiftSyntaxMacrosTest",
      dependencies: [
        "SwiftDiagnostics", "SwiftOperators", "SwiftParser",
        "_SwiftSyntaxTestSupport", "SwiftSyntaxBuilder",
        "SwiftSyntaxMacros",
      ]
    ),
    .testTarget(
      name: "PerformanceTest",
      dependencies: ["IDEUtils", "SwiftSyntax", "SwiftSyntaxParser", "SwiftParser"],
      exclude: ["Inputs"]
    ),
    .testTarget(
      name: "SwiftParserTest",
      dependencies: [
        "SwiftDiagnostics", "SwiftOperators", "SwiftParser",
        "_SwiftSyntaxTestSupport", "SwiftSyntaxBuilder",
        .target(name: "WASIHelpers", condition: .when(platforms: [.wasi])),
      ]
    ),
    .testTarget(
      name: "SwiftParserDiagnosticsTest",
      dependencies: ["SwiftDiagnostics", "SwiftParserDiagnostics"]
    ),
    .testTarget(
      name: "SwiftOperatorsTest",
      dependencies: [
        "SwiftOperators", "_SwiftSyntaxTestSupport",
        "SwiftParser",
      ]
    ),
    .testTarget(
      name: "SwiftRefactorTest",
      dependencies: [
        "SwiftRefactor", "SwiftSyntaxBuilder", "_SwiftSyntaxTestSupport",
      ]
    ),
    .testTarget(
      name: "SwiftCompilerPluginTest",
      dependencies: [
        "SwiftCompilerPlugin"
      ]
    ),
  ]
)

if ProcessInfo.processInfo.environment["SWIFTCI_USE_LOCAL_DEPS"] == nil {
  // Building standalone.
  package.dependencies += [
    .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "1.2.2"))
  ]
} else {
  package.dependencies += [
    .package(path: "../swift-argument-parser")
  ]
}
