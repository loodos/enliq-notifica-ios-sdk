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
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v2.0.0/eiqnotifica.xcframework.zip",
            checksum: "b3b9a2004d61cf6fb61d6ebb59689ec3170a8161ba2954ae0cfe4f603dd0f212"
        )
    ]
)
