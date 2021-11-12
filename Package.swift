// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DeclarativeUIKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "DeclarativeUIKit",
            targets: ["DeclarativeUIKit"]),
    ],
    targets: [
        .target(
            name: "DeclarativeUIKit",
            dependencies: []),
        .testTarget(
            name: "DeclarativeUIKitTests",
            dependencies: ["DeclarativeUIKit"]),
    ]
)
