// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AMSlideMenu",
	platforms: [.iOS(.v10)],
    products: [
        .library(name: "AMSlideMenu", targets: ["AMSlideMenu"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AMSlideMenu",
            dependencies: [],
			path: "AMSlideMenu"),
    ],
	swiftLanguageVersions: [.v5]
)
