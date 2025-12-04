// swift-tools-version: 6.2

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
            targets: ["ProcuretAPI"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ProcuretAPI",
            dependencies: []
        ),
        .testTarget(
            name: "ProcuretAPITests",
            dependencies: ["ProcuretAPI"]
        ),
    ]
)
