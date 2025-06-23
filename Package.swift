// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "NoteApp",
  defaultLocalization: "en",
  platforms: [
    .macOS(.v26),
    .iOS(.v26),
  ],
  products: [
    .library(
      name: "NoteApp",
      targets: ["NoteApp"]
    ),
  ],
  targets: [
    .target(
      name: "NoteApp"
    ),
    .testTarget(
      name: "NoteAppTests",
      dependencies: ["NoteApp"]
    ),
  ]
)
