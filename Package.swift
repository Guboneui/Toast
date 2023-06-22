// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Toast",
  platforms: [.iOS(.v14)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Toast",
      targets: ["Toast"]),
  ],
  dependencies: [
    .package(url: "https://github.com/layoutBox/PinLayout", from: "1.10.4")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Toast",
      dependencies: ["PinLayout"]),
    .testTarget(
      name: "ToastTests",
      dependencies: ["Toast"]),
  ]
)
