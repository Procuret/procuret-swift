// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProcuretAPI",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "ProcuretAPI",
            targets: ["ProcuretAPI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ProcuretAPI",
            dependencies: []),
        .testTarget(
            name: "ProcuretAPITests",
            dependencies: ["ProcuretAPI"]),
    ]
)
