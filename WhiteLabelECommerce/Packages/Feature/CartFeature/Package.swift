// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CartFeature",
  platforms: [
    .iOS(.v15),
    .macOS(.v12)
  ],
  products: [
    // Cart define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "CartFeature",
      targets: ["CartFeature"])
  ],
  dependencies: [
    .package(path: "../../Backend"),
    .package(path: "../../NotoriousComponentsKit"),
    .package(path: "../../AppState"),
    .package(path: "../../Mock")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "CartFeature",
      dependencies: [
        "Backend",
        "NotoriousComponentsKit",
        "AppState",
        "Mock"
      ],
      path: "Sources"
    ),
    .testTarget(
      name: "CartFeatureTests",
      dependencies: ["CartFeature", "Mock"],
      path: "Tests"
    )
  ],
  swiftLanguageVersions: [
    .version("5.5")
  ]
)
