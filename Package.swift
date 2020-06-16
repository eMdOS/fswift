// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "fswift",
    products: [
        .library(
            name: "fswift",
            targets: ["fswift"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "fswift",
            dependencies: []
        ),
        .testTarget(
            name: "fswiftTests",
            dependencies: ["fswift"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
