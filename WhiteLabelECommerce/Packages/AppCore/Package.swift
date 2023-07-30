// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppCore",
  platforms: [
    .iOS(.v15),
    .macOS(.v12)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "AppCore",
      targets: ["AppCore"])
  ],
  dependencies: [
    .package(path: "../AppState"),
    .package(path: "../NotoriousComponentsKit"),
    .package(path: "../Feature/LoginFeature"),
    .package(path: "../Feature/ProductsFeature"),
    .package(path: "../Feature/RegistrationFeature"),
    .package(path: "../Feature/RootFeature"),
    .package(path: "../Feature/TabBarFeature"),
    .package(path: "../Feature/WelcomeFeature")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "AppCore",
      dependencies: [
        "AppState",
        "NotoriousComponentsKit",
        "LoginFeature",
        "ProductsFeature",
        "RegistrationFeature",
        "RootFeature",
        "TabBarFeature",
        "WelcomeFeature"
      ],
      path: "Sources"
    ),
    .testTarget(
      name: "AppCoreTests",
      dependencies: ["AppCore"],
      path: "Tests"
    )
  ],
  swiftLanguageVersions: [
    .version("5.5")
  ]
)
