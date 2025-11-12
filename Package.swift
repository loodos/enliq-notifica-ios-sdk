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
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v2.0.9/eiqnotifica.xcframework.zip",
            checksum: "8b2583d219884b6cfb798e2654f03387d0ce66f33e87b38efee58c72fa7c941f"
        )
    ]
)
