// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "POViewController",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "POViewController",
            targets: ["POViewController"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "POViewController",
            dependencies: [],
            path: "Sources"
        )
    ]
)
