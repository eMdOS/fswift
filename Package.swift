// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "fswift",
    products: [
        .library(name: "Arrows", targets: ["Arrows"]),
        .library(name: "Algebra", targets: ["Algebra"]),
        .library(name: "Extended", targets: ["Extended"]),
        .library(
            name: "fswift",
            targets: ["Arrows", "Algebra", "Extended"]
        )
    ],
    dependencies: [],
    targets: [
        // Arrows
        .target(name: "Arrows"),
        // Algebra
        .target(name: "Algebra", dependencies: ["Arrows"]),
        .testTarget(name: "AlgebraTests", dependencies: ["Algebra"]),
        // Extended
        .target(name: "Extended"),
        .testTarget(name: "ExtendedTests", dependencies: ["Extended"]),
    ],
    swiftLanguageVersions: [.v5]
)
