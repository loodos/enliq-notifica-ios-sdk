// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "EIQNotifica",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "EIQNotifica",
            targets: ["EIQNotifica", "EIQNotificaSources"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.8.1")
        )
    ],
    targets: [
        .target(
            name: "EIQNotificaSources",
            dependencies: [
                "Alamofire",
            ],
            path: "Sources"
        ),
        .binaryTarget(
            name: "EIQNotifica",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v2.0.8/eiqnotifica.xcframework.zip",
            checksum: "535340869c62342c542fc162048aa59a6c7f93f6e0a429923fd0ad090eafa13b"
        )
    ]
)
