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
            checksum: "3dd0bf307b39c46e0f779d00911c84d936ac08f2381b7198d1c24e69b7390a0c"
        ),
        .binaryTarget(
            name: "EIQNotificaNotificationService",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.0/EIQNotificaNotificationService.xcframework.zip",
            checksum: "016ab02268cb5ad2166f38901f2ca0c6c72f281d518b435d48957dc5e2ab1a77"
        ),
        .binaryTarget(
            name: "EIQNotificaNotificationContent",
            url: "https://github.com/loodos/enliq-notifica-ios-sdk/releases/download/v3.5.0/EIQNotificaNotificationContent.xcframework.zip",
            checksum: "51bc7784b0e4234b427b0a967402df595a8be28e88795b198d706841574fa860"
        ),
    ]
)
