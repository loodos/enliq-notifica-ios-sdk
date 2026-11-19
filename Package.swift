// swift-tools-version: 5.9
//
// EIQNotifica iOS SDK — v3.5.0
// Bu dosya otomatik üretilir; elle düzenlemeyin.

import PackageDescription

let package = Package(
    name: "EIQNotifica",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "EIQNotifica", targets: ["EIQNotifica"]),
        .library(name: "EIQNotificaNotificationService", targets: ["EIQNotificaNotificationService"]),
        .library(name: "EIQNotificaNotificationContent", targets: ["EIQNotificaNotificationContent"]),
    ],
    targets: [
        .binaryTarget(
            name: "EIQNotifica",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.0/EIQNotifica.xcframework.zip",
            checksum: "c126961689ed31b314f547e9dfe351248588290f0a838d8c7c5b666ffe27c4bf"
        ),
        .binaryTarget(
            name: "EIQNotificaNotificationService",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.0/EIQNotificaNotificationService.xcframework.zip",
            checksum: "cced347ea8fee7551ac6c595aa32f4d93e13ac3c6a57d7d47574a1b245e95356"
        ),
        .binaryTarget(
            name: "EIQNotificaNotificationContent",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.0/EIQNotificaNotificationContent.xcframework.zip",
            checksum: "f285343adef63b58789368d6c3928358b6177a8061d90d65700332ad644f6c99"
        ),
    ]
)
