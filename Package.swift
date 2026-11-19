// swift-tools-version: 5.9
//
// EIQNotifica iOS SDK — v3.5.1
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
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.1/EIQNotifica.xcframework.zip",
            checksum: "f76c0365b0783dab6be6b1023a1b9e5eea92f2045f9ace9c25768ebd17e422a6"
        ),
        .binaryTarget(
            name: "EIQNotificaNotificationService",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.1/EIQNotificaNotificationService.xcframework.zip",
            checksum: "e158cb51f3cac5544db7dea14640b9919712ad53dc3380e61525ccb1e9f07d3a"
        ),
        .binaryTarget(
            name: "EIQNotificaNotificationContent",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.1/EIQNotificaNotificationContent.xcframework.zip",
            checksum: "2c081aaf6878e9aae3fe323e90b6379ab7e95fd5d53e340499af43e9cde058b8"
        ),
    ]
)
