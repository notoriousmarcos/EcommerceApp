// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UI",
  platforms: [
    .iOS(.v15),
    .macOS(.v12)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "UI",
      targets: ["UI"])
  ],
  dependencies: [],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "UI",
      dependencies: [],
      path: "Sources",
      resources: [.process("Assets.xcassets"), .process("Fonts")]
    ),
    .testTarget(
      name: "UITests",
      dependencies: ["UI"],
      path: "Tests"
    )
  ],
  swiftLanguageVersions: [
    .version("5.5")
  ]
)
