// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "lint-staged",
    products: [
        .executable(name: "lint-staged", targets: ["LintStaged"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "LintStaged",
            dependencies: ["LintStagedCore"]),
        .target(name: "LintStagedCore"),
        .testTarget(
            name: "LintStagedTests",
            dependencies: ["LintStaged"]),
    ]
)
