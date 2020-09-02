// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OxeNetworking",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "OxeNetworking",
            targets: ["OxeNetworking"]),
        .library(
            name: "RxOxeNetworking",
            targets: ["RxOxeNetworking"]),
        
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "OxeNetworking",
            dependencies: ["Moya", "SwiftyJSON"]),
        .target(
            name: "RxOxeNetworking",
            dependencies: ["OxeNetworking", .product(name: "RxMoya", package: "Moya")]),
        .testTarget(
            name: "OxeNetworkingTests",
            dependencies: ["OxeNetworking"]),
    ]
)