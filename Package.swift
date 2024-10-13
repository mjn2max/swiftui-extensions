// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUI-Extensions",
    platforms: [.iOS(.v15), .macOS(.v13), .macCatalyst(.v15), .tvOS(.v15), .watchOS(.v8)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftUI-Extensions",
            targets: ["SwiftUI-Extensions"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftUI-Extensions",
            path: "",
             exclude: [
                 "Demo/"
             ]
        ),
        .testTarget(
            name: "SwiftUI-ExtensionsTests",
            dependencies: ["SwiftUI-Extensions"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
