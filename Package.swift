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
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/0.0.2/eiqnotifica.xcframework.zip",
            checksum: "d78037143f537340cdec98dad2f0fe057417f5770d2fa00904637cca2bd096cb"
        )
    ]
)
