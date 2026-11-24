// swift-tools-version: 5.9
//
// EIQNotifica iOS SDK — v3.5.2
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
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.2/EIQNotifica.xcframework.zip",
            checksum: "3613f32741d94da00e338cfacbb75fea9d6c1ab5fcaaea274d9356c44d89ceae"
        ),
        .binaryTarget(
            name: "EIQNotificaNotificationService",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.2/EIQNotificaNotificationService.xcframework.zip",
            checksum: "42fa974d378a34e83c1272c1860a1b56729477a0ab13585726f4d9d8da9023d2"
        ),
        .binaryTarget(
            name: "EIQNotificaNotificationContent",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.2/EIQNotificaNotificationContent.xcframework.zip",
            checksum: "b82dbcac4e668d0f57b71f5faa8045722957f61ab8bd57dbf84e1dc4ae212b2e"
        ),
    ]
)
