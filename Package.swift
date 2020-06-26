// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "fswift",
    products: [
        .library(name: "fswift", targets: ["Arrows", "Algebra", "Extended"])
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
