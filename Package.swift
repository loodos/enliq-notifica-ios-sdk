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
            checksum: "2dfa209be9ef744ccb8068c65f41272139da20f2a9fdbf5a2ebb9e42b5d45e00"
        ),
        .binaryTarget(
            name: "EIQNotificaNotificationService",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.0/EIQNotificaNotificationService.xcframework.zip",
            checksum: "156d496c71c633b2b5019bd09ab446b55e6b57c0858cedd3a1113fdccb94efaa"
        ),
        .binaryTarget(
            name: "EIQNotificaNotificationContent",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.0/EIQNotificaNotificationContent.xcframework.zip",
            checksum: "eafb511569ed8c6162402f40a200ad5bafd69d0e28f50924b12763040f292452"
        ),
    ]
)
