// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ProductsFeature",
  platforms: [
    .iOS(.v15),
    .macOS(.v12)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "ProductsFeature",
      targets: ["ProductsFeature"])
  ],
  dependencies: [
    .package(path: "../Backend"),
    .package(path: "../Mock")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "ProductsFeature",
      dependencies: [
        "Backend"
      ],
      path: "Sources"
    ),
    .testTarget(
      name: "ProductsFeatureTests",
      dependencies: ["ProductsFeature", "Mock"],
      path: "Tests"
    )
  ],
  swiftLanguageVersions: [
    .version("5.5")
  ]
)
