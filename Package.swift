// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "lint-staged",
    products: [
        .executable(name: "lint-staged", targets: ["LintStaged"])
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit.git", from: "1.0.0"),
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "LintStaged",
            dependencies: ["LintStagedCore"]),
        .target(
            name: "LintStagedCore",
            dependencies: ["PathKit", "SwiftCLI"]),
        .testTarget(
            name: "LintStagedTests",
            dependencies: ["LintStaged"]),
    ]
)
