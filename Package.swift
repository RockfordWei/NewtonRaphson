// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NewtonRaphson",
    products: [.library(name: "NewtonRaphson", targets: ["NewtonRaphson"])],
    dependencies: [],
    targets: [
        .target(name: "NewtonRaphson", dependencies: []),
        .testTarget(name: "NewtonRaphsonTests", dependencies: ["NewtonRaphson"])
    ]
)
