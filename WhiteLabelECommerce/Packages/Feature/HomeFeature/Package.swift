// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "HomeFeature",
  platforms: [
    .iOS(.v15),
    .macOS(.v12)
  ],
  products: [
    // Home define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "HomeFeature",
      targets: ["HomeFeature"])
  ],
  dependencies: [
    .package(path: "../../ShopCore"),
    .package(path: "../../AppState"),
    .package(path: "../../NotoriousComponentsKit"),
    .package(path: "../../Mock")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "HomeFeature",
      dependencies: [
        "ShopCore",
        "AppState",
        "NotoriousComponentsKit"
      ],
      path: "Sources"
    ),
    .testTarget(
      name: "HomeFeatureTests",
      dependencies: ["HomeFeature", "Mock"],
      path: "Tests"
    )
  ],
  swiftLanguageVersions: [
    .version("5.5")
  ]
)
