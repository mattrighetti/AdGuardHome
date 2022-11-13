// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "adguard-home-swift",
    platforms: [SupportedPlatform.macOS(.v10_15), SupportedPlatform.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AdGuardHomeClient",
            targets: ["AdGuardHomeClient"]),
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AdGuardHomeClient", path: "Sources"),
        .testTarget(
            name: "adguard-home-swiftTests",
            dependencies: ["AdGuardHomeClient"]),
    ]
)
