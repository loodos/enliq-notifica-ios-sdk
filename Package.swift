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
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/2.0.6/eiqnotifica.xcframework.zip",
            checksum: "cbf6227aaea82933c787b5cd2f8d7714e4273fdfeb4ecf9b07bc42a1e551e806"
        )
    ]
)
