<p align="center">
  <img src="https://i.ibb.co/zh0Lrz6J/test.png" alt="Enliq" width="320"/>
</p>

<h1 align="center">EIQNotifica iOS SDK</h1>

<p align="center">
  <a href="https://github.com/loodos/enliq-notifica-ios-sdk/releases/latest"><img src="https://img.shields.io/github/v/release/loodos/enliq-notifica-ios-sdk?label=release&sort=semver" alt="Latest release"/></a>
  <img src="https://img.shields.io/badge/platform-iOS%2015.0%2B-blue.svg" alt="Platform iOS 15.0+"/>
  <a href="https://swift.org/package-manager"><img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" alt="Swift Package Manager compatible"/></a>
  <img src="https://img.shields.io/badge/distribution-XCFramework-lightgrey.svg" alt="Binary XCFramework"/>
</p>

<p align="center">
  Push notifications, rich media, inbox, channel subscriptions and commerce events<br/>
  for iOS apps powered by the <a href="https://www.enliq.com">Enliq</a> customer engagement platform.
</p>

<p align="center">
  <a href="https://developer.enliq.com"><b>Developer Docs</b></a> ·
  <a href="https://github.com/loodos/enliq-notifica-ios-sdk/releases"><b>Releases</b></a> ·
  <a href="#support"><b>Support</b></a>
</p>

---

## Contents

- [Requirements](#requirements)
- [Libraries](#libraries)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Push Notifications](#push-notifications)
- [Rich Notifications](#rich-notifications)
- [Users](#users)
- [Channels](#channels)
- [Inbox](#inbox)
- [Commerce Events](#commerce-events)
- [Logging](#logging)
- [Migrating to 3.x](#migrating-to-3x)
- [Support](#support)

## Requirements

| | Minimum |
|---|---|
| iOS | 15.0 |
| Xcode | 16.0 |
| Swift | 5.9 |

The SDK is distributed as precompiled **binary XCFrameworks** built with library evolution, so it works with any newer Swift compiler. It has **no third-party dependencies** to resolve in your project.

## Libraries

| Library | Add to target | Purpose |
|---|---|---|
| `EIQNotifica` | App | Core SDK: initialization, push handling, users, channels, inbox, events. |
| `EIQNotificaNotificationService` | Notification Service Extension | Downloads and attaches images and videos for rich notifications. |
| `EIQNotificaNotificationContent` | Notification Content Extension | Base for custom notification UI (Notification Content Extension). |

## Installation

### Swift Package Manager

**Xcode:** `File` → `Add Package Dependencies…` → enter the URL below → choose **Up to Next Major Version**.

```
https://github.com/loodos/enliq-notifica-ios-sdk
```

Add `EIQNotifica` to your app target, and the extension libraries to their extension targets if you use them.

**Package.swift:**

```swift
dependencies: [
    .package(url: "https://github.com/loodos/enliq-notifica-ios-sdk.git", .upToNextMajor(from: "3.0.0"))
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "EIQNotifica", package: "enliq-notifica-ios-sdk")
        ]
    )
]
```

## Quick Start

**1. Add `Enliq-Config.plist`** to your app target (and to your Notification Service Extension target, if any) with the values provided by Enliq. See [Configuration](#configuration).

**2. Enable capabilities** on your app target: *Push Notifications*, *Background Modes → Remote notifications*, and *App Groups* if you use extensions.

**3. Initialize the SDK** as early as possible:

```swift
import UIKit
import EIQNotifica

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        EIQNotificaManager.shared.initialize(options: [.requestPermissionOnInit])
        EIQNotificaManager.shared.pushDelegate(self)
        return true
    }
}

extension AppDelegate: EIQMessageDelegate {
    func eiqDeviceToken(_ messaging: EIQMessage, deviceToken: String?) {}
    func eiqNotificationAction(actionIdentifier: String, actionURL: String?) {}
    func eiqDidReciveSlientPush(payload: EIQPushPayload?) {}
}
```

That's it. The SDK registers the device, handles the APNs token and tracks notification interactions automatically.

## Configuration

### `Enliq-Config.plist`

| Key | Required | Description |
|---|---|---|
| `NOTIFICA_APP_ID` | ✅ | Your application identifier, provided by Enliq. |
| `APP_GROUP_ID` | ✅ with extensions | Shared App Group used to share data between the app and its extensions. |
| `NOTIFICA_BASE_URL` | — | Custom API endpoint (e.g. staging). Defaults to production. |
| `NOTIFICA_SSL_ENABLE` | — | `YES` to enable SSL pinning for SDK requests. |

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>NOTIFICA_APP_ID</key>
    <string>YOUR_APP_ID</string>
    <key>APP_GROUP_ID</key>
    <string>group.com.yourcompany.yourapp</string>
</dict>
</plist>
```

### Initialization options

| Option | Description |
|---|---|
| `.requestPermissionOnInit` | Asks the user for notification permission when the SDK initializes. |

### Multiple environments

Load a different configuration file per build configuration:

```swift
func configureEnliq() {
    #if DEBUG
    let resource = "Enliq-Config-Dev"
    #else
    let resource = "Enliq-Config"
    #endif

    let environment = Bundle.main
        .path(forResource: resource, ofType: "plist")
        .flatMap(EIQNotificaEnvironment.init(contentsOfFile:))

    EIQNotificaManager.shared.initialize(environment: environment, options: [])
}
```

<details>
<summary>Alternative: copy the right plist at build time with a Run Script phase</summary>

Useful when extensions must read the same environment. Add the script below to your project and run it from a **Run Script** build phase placed **above "Copy Bundle Resources"** in the app target and in the Notification Service Extension target.

```bash
#!/bin/bash -l
# ${PROJECT_DIR}/scripts/enliq.sh
CONFIG_DIR="${PROJECT_DIR}/YourApp/Config"

if [[ "${CONFIGURATION}" == *"Dev"* ]]; then
  cp -v "${CONFIG_DIR}/Enliq-Config-Dev.plist" "${CONFIG_DIR}/Enliq-Config.plist"
elif [[ "${CONFIGURATION}" == *"Beta"* ]]; then
  cp -v "${CONFIG_DIR}/Enliq-Config-Beta.plist" "${CONFIG_DIR}/Enliq-Config.plist"
else
  cp -v "${CONFIG_DIR}/Enliq-Config-Store.plist" "${CONFIG_DIR}/Enliq-Config.plist"
fi
```

</details>

## Push Notifications

Request permission manually (if you don't use `.requestPermissionOnInit`):

```swift
EIQNotificaManager.shared.requestPushNotificationAuthorization(for: [.alert, .badge, .sound])
```

`EIQMessageDelegate` callbacks:

| Method | Called when |
|---|---|
| `eiqDeviceToken(_:deviceToken:)` | The APNs device token is received. |
| `eiqNotificationAction(actionIdentifier:actionURL:)` | The user taps a notification or an action button. Use `actionURL` for deep links. |
| `eiqDidReciveSlientPush(payload:)` | A silent push is received. |

If your app manages notification permission itself, keep the SDK in sync:

```swift
EIQNotificaManager.shared.updateStatus(pushEnabled: true)
```

## Rich Notifications

1. In Xcode, `File` → `New` → `Target…` → **Notification Service Extension**.
2. Add the `EIQNotificaNotificationService` library to the extension target.
3. Add `Enliq-Config.plist` and the same **App Group** to the extension target.
4. Subclass `EIQNotificaNotificationService`:

```swift
import EIQNotificaNotificationService

final class NotificationService: EIQNotificaNotificationService {}
```

Images and videos sent from the Enliq panel are downloaded and attached automatically.

## Users

```swift
let user = EIQNotificaUser(
    externalId: "USER_ID",
    name: "Jane",
    surname: "Doe",
    email: "jane@example.com",
    phone: "5551234567"
)
EIQNotificaManager.shared.setUser(user) { result in /* Result<Bool, Error> */ }
```

Update custom properties defined in the Enliq panel:

```swift
EIQNotificaManager.shared.setCustomProperties(
    externalId: "USER_ID",
    attributes: ["membership": "gold"],
    completion: nil
)
```

On sign-out, clear the local user session:

```swift
EIQNotificaManager.shared.logout()
```

## Channels

```swift
EIQNotificaManager.shared.getChannels(externalId: "USER_ID") { result in
    // Result<[EIQChannels], Error>
}

EIQNotificaManager.shared.subscribe(channelId: "CHANNEL_ID") { result in }
EIQNotificaManager.shared.unsubscribe(channelId: "CHANNEL_ID") { result in }
```

## Inbox

```swift
EIQNotificaManager.shared.getInbox { items in
    // [EIQInbox]
}

if let deliveryId = item.deliveryId {
    EIQNotificaManager.shared.updateInboxStatus(deliveryId: deliveryId, status: .read) { result in }
}

EIQNotificaManager.shared.getCount { count in
    // count.totalCount, count.unreadCount
}

EIQNotificaManager.shared.deleteAll { isDeleted in }
```

`EIQInboxStatus`: `.unread`, `.read`, `.deleted`.

## Commerce Events

```swift
let items = [
    EIQNotificaBasketItem(id: "SKU_001", name: "T-Shirt", quantity: 2, price: 99.95, totalAmount: 199.90)
]

// When the basket changes
EIQNotificaManager.shared.addToBasketEvent(basketId: "BASKET_123", totalAmount: 199.90, products: items)

// After a successful payment
EIQNotificaManager.shared.purchaseEvent(basketId: "BASKET_123", totalAmount: 199.90, products: items)
```

## Logging

```swift
EIQNotificaManager.shared.logLevel(logLevel: .debug) // .error, .warning, .notice, .info, .debug, .none
```

## Migrating to 3.x

- Minimum deployment target is now **iOS 15.0**.
- The SDK no longer brings Alamofire into your project. If your app uses Alamofire directly, add it as your own dependency.
- Import the module as `import EIQNotifica` (previously `EnliqNotifica`).
- `EIQNotificaNotificationService` and `EIQNotificaNotificationContent` are now available as separate libraries.
- If you previously used the SDK from source, run **Product → Clean Build Folder** (or delete DerivedData) once after switching. Stale source-built `EIQNotifica*` modules otherwise cause `Undefined symbols` linker errors.

## Support

- **Integration guides & changelog:** [developer.enliq.com](https://developer.enliq.com)
- **Bug reports:** [GitHub Issues](https://github.com/loodos/enliq-notifica-ios-sdk/issues)
- **Account & panel questions:** contact your Enliq account manager.

---

<p align="center">© Enliq. All rights reserved.</p>
