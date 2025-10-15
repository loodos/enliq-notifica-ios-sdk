<p align="center">
  <img src="https://i.ibb.co/zh0Lrz6J/test.png"/>
</p>

## EIQNotifica iOS SDK
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://cocoapods.org/pods/EIQNotifica)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![License](https://img.shields.io/badge/license-apache%202.0-blue.svg?style=flat)](https://cocoapods.org/pods/EIQNotifica)
---

[EIQNotifica](https://www.enliq.com) iOS SDK for mobile app engagement platform

**EIQNotifica** is a powerful and flexible SDK for managing push and local notifications in your iOS applications. It simplifies notification delivery, channel management, user association, and provides a clean, extensible API for custom notification workflows. Designed for modern Swift, EIQNotifica enables you to quickly integrate robust notification features with minimal effort. See details at https://developer.enliq.com


## Installation
EIQNotifica iOS SDK is fully compatible with the latest stable version of Swift and integrates seamlessly with modern iOS applications.

## Requirements
- iOS 12.0+
- Xcode 11.0+
- Analytics is available through CocoaPods and Carthage.

### CocoaPods
// TODO: Feature

### Swift Package Manager(SPM)

In Xcode, select File > Add Packages..

Enter the package URL for this repository https://github.com/loodos/eiqnotifica-ios.git.

### Carthage
// TODO: Feature

## Usage

Before starting to use the EIQNotifica SDK, you need to add the required plist file to your project and initialize the SDK.

#### 1. Add the `Enliq-Config.plist` File

To ensure the SDK works properly, add the provided `Enliq-Config` file to your Xcode project. This file contains the keys and configurations necessary for your app to communicate with the Enliq platform.

#### 2. Initializing the SDK

In your AppDelegate file, the SDK should be initialized when the app launches. You can check the example below:

```swift
import UIKit
import EIQNotifica

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize EIQNotifica SDK
        EIQNotificaManager.shared.initialize(options: [])
        return true
    }
}
```

In the code above, the call `EIQNotificaManager.shared.initialize(options: [])` starts the SDK and prepares the notification infrastructure. Remember to manage push notification permissions in your app for the SDK to function correctly.

#### 2.1 Environment-Based Initialization

You can use the example below to initialize the SDK according to different environments. This allows applying different configurations for development, testing, and production environments:

```swift
import UIKit
import EIQNotifica

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         #if DEBUG
        configureEIQNotifica(for: "Enliq-Config-Dev")
        #elseif STAGING
        configureEIQNotifica(for: "Enliq-Config-Stage")
        #else
        EIQNotificaManager.shared.initialize(options: [])
        #endif
        return true
    }
    
    func configureEIQNotifica(for resource: String) {
        if let file = Bundle.main.path(forResource: resource, ofType: "plist"),
           let options = EIQNotificaEnvironment(contentsOfFile: file) {
            EIQNotificaManager.shared.initialize(
                environment: options,
                options: []
            )
        } else {
            EIQNotificaManager.shared.initialize(options: [])
        }    
    }
}
```

In this example, the appropriate environment is selected based on compile-time defined conditions such as `DEBUG`, `STAGING`, or others, and the SDK is initialized in that environment. Thus, different API keys or configurations can be used for different environments.

#### 2.1.1 Initializing With Options The SDK

You can configure the SDK initialization using predefined options in the `EIQNotificationOption` enum.  
These options allow you to customize SDK behavior during initialization, such as automatically requesting notification permissions or enabling SSL pinning.

**Available Options:**

```swift
public enum EIQNotificationOption {
    case requestPermissionOnInit
    case pinnedSSL
}
```

- **`requestPermissionOnInit`** → Automatically requests push notification permissions from the user when the SDK initializes.  
- **`pinnedSSL`** → Enables SSL pinning for enhanced network security during API communication.

**Example Usage:**

```swift
import UIKit
import EIQNotifica

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Initialize SDK with options
        EIQNotificaManager.shared.initialize(options: [.requestPermissionOnInit, .pinnedSSL])
        return true
    }
}
```

In this example:  
- The SDK will automatically request notification permissions on startup.  
- SSL pinning will be activated, ensuring secure communication with the Enliq backend.

#### 2.2 Setting the Log Level

You can use the example below to set the runtime log level of the SDK. This allows you to control the detail level of logs produced by the SDK:

```swift
EIQNotificaManager.shared.logLevel(logLevel: .info)
```

This code sets the log level to `info`, so informational messages and certain logs are printed to the console. This feature is useful during debugging and monitoring app behavior.

##### 2.3 Requesting Push Notification Permissions

You can request push notification permissions from the user with this call. Use the following code to ask for permissions::

```swift
EIQNotificaManager.shared.requestPushNotificationAuthorization(for: [.alert, .badge, .sound])
```

##### 2.4 Push Notifications and Delegate Usage
Also, you can set a delegate to receive device tokens and message events from the SDK. The example below shows how to set the `pushDelegate` and implement the required protocol:


```swift
EIQNotificaManager.shared.pushDelegate(self)

extension AppDelegate: EIQMessageDelegate {
    // 1️⃣ Device Token
    func eiqDeviceToken(
        _ messaging: EIQNotifica.EIQMessage,
        deviceToken: String?
    ) {}
    
    // 2️⃣ Notification Actions
    func eiqNotificationAction(
        actionIdentifier: String,
        actionURL: String?
    ) {
        // Called when the user taps on a notification action button.
        // - actionIdentifier: ID of the tapped action (e.g., "EIQ_ACTION")
        // - actionURL: The URL associated with the button (deeplink or external link)
        // Use this to navigate to a screen or open a link.
    }
}
```


This code sets the delegate to receive device tokens and message events from the SDK. Thus, push notification management and related events can be handled within the AppDelegate.

#### 2.4.1 Handling Rich Notifications

To enable rich notifications (displaying images or videos in notifications), you need to add a **Notification Service Extension** to your Xcode project and configure it to use the EIQNotifica SDK.

**Steps to enable rich notifications:**

1. **Create a Notification Service Extension:**
   - In Xcode, select your project, then choose `File > New > Target...`.
   - Select **Notification Service Extension** and click **Next**.
   - Name the extension (e.g., `NotificaNotificationService`), then click **Finish**.
   - When prompted, activate the new scheme.

2. **Configure the Extension:**
   - Open the generated `NotificationService.swift` file in your extension target.
   - Import the EIQNotifica SDK.
   - Change the class to subclass `EIQNotificaNotificationService` instead of `UNNotificationServiceExtension`.

**Example `NotificationService.swift`:**

```swift
import UserNotifications
import EIQNotifica

class NotificationService: EIQNotificaNotificationService {
    // No need to override anything unless you want to customize behavior.
}
```

By using `EIQNotificaNotificationService` as the superclass, the SDK will automatically handle downloading and attaching images or videos to your notifications if the push payload includes a `media-url` key.

**How to send media with your notifications:**

- Include a `media-url` key in your push payload pointing to an image or video URL. The SDK will download and attach the media to the notification automatically.

**Example payload with image:**
```json
{
  "aps": {
    "alert": {
      "title": "EIQNotifica",
      "body": "EIQNotifica picture test"
    }
  },
  "media-url": "https://example.com/image.png"
}
```

**Example payload with video:**
```json
{
  "aps": {
    "alert": {
      "title": "EIQNotifica",
      "body": "EIQNotifica video test"
    }
  },
  "media-url": "https://example.com/video.mp4"
}
```

With this setup, your users will receive rich notifications with images or videos attached, simply by including the `media-url` key in your push notification payload.

#### 2.5 Assigning a User

You can associate user information with the SDK using the `setUser(_ user: EIQNotificaUser)` method. This ensures notifications and user interactions are matched to the correct user.

```swift
let user = EIQNotificaUser()
user.externalId = "EXAMPLE_UNIQUE_ID"
user.name = "John"
user.surname = "Doe"
user.email = "john.doe@example.com"
user.phone = "5551234567"
EIQNotificaManager.shared.setUser(user)
```

This code assigns the specified user information to the SDK and enables user-specific notification management.

#### 2.6 Assigning Custom Properties  

The SDK allows you to update user-specific parameters (custom properties) defined via the **Enliq Notifica Panel** from within the application.  
This feature enables easy application of user-specific filtering, segment creation, or targeted notification scenarios.  

In the example below, custom parameters for the user matching the `externalId` value are updated:  

```swift
EIQNotificaManager.shared.setCustomProperties(
    externalId: "EXAMPLE_UNIQUE_ID",
    attributes: [
        "customparam1": "Enliq Notifica"
    ],
    completion: nil
)
```

With this call:  
- **`externalId`**: Uniquely identifies the user.  
- **`attributes`**: Contains key-value pairs of custom properties defined in the panel.  
- **`completion`**: (Optional) can be used to receive feedback when the operation completes.  

Thus, custom properties defined on the panel can be updated from the application side, allowing more flexible notification scenarios based on user behavior and interactions.  

#### 2.7 Fetching the Channel List  

The SDK provides the following method to retrieve the list of channels associated with a user:  

```swift
EIQNotificaManager.shared.getChannels(
    externalId: "EXAMPLE_UNIQUE_ID"
) { result in
    switch result {
    case .success(let channels):
        print("Channels associated with the user: \(channels)")
    case .failure(let error):
        print("Failed to fetch channel list: \(error)")
    }
}
```

With this call:  
- **`externalId`**: Identifies the user whose channel list will be fetched.  
- **`completion`**: Returns the channel list (`[EIQChannels]`) or error information when the operation completes.  

This allows easy querying of existing notification channels for the user.  

#### 2.8 Channel Subscription Management  

The SDK provides `subscribe` and `unsubscribe` methods to manage users' channel subscriptions.  
With these methods, users can subscribe to or unsubscribe from specific channels.  

```swift
// Start channel subscription
EIQNotificaManager.shared.subscribe(
    externalId: "EXAMPLE_UNIQUE_ID",
    channelKey: "NEWS_CHANNEL"
) { result in
    switch result {
    case .success(let success):
        print("Channel subscription successful: \(success ?? false)")
    case .failure(let error):
        print("Subscription operation failed: \(error)")
    }
}

// Unsubscribe from channel
EIQNotificaManager.shared.unsubscribe(
    externalId: "EXAMPLE_UNIQUE_ID",
    channelKey: "NEWS_CHANNEL"
) { result in
    switch result {
    case .success(let success):
        print("Unsubscribed from channel: \(success ?? false)")
    case .failure(let error):
        print("Unsubscription operation failed: \(error)")
    }
}
```

With these calls:  
- **`externalId`**: Uniquely identifies the user.  
- **`channelKey`**: The key of the channel to subscribe to or unsubscribe from.  
- **`completion`**: Returns success (`Bool`) or error information when the operation completes.  

###  

### 2.9 Fetch Inbox  
The EIQNotifica SDK provides methods to manage notifications delivered to users through the inbox. It can fetch messages based on their status (read, unread, deleted).

```swift
let filter = EIQInboxFilter(pageSize: 10, status: [.read, .unread, .deleted])
EIQNotificaManager.shared.getInbox(filter: filter) { result in
    switch result {
    case .success(let response):
        print("Inbox items: \(response)")
    case .failure(let error):
        print("Failed to fetch inbox: \(error)")
    }
}
```

With these calls:  
- **`filter`**: Defines filtering options such as statuses (`read`, `unread`, `deleted`) and page size.  
- **`completion`**: Returns an array of `EIQInbox` (`[EIQInbox]`) or error information when the operation completes.

###

#### 3.0 Update Inbox Status
Updates the status of a specific inbox item. You can mark an item as read, unread, or deleted by providing its unique key.
This operation returns the result through the completion handler.

```swift
EIQNotificaManager.shared.updateInboxStatus(
    key: "INBOX_ITEM_KEY",
    status: .read
) { result in
    switch result {
    case .success(let success):
        print("Status updated: \(success ?? false)")
    case .failure(let error):
        print("Failed to update inbox status: \(error)")
    }
}
```

With these parameters:  
- **`key`**: The unique identifier of the inbox item whose status will be updated.  
- **`status`**: The new status to assign to the inbox item (e.g., `.read`, `.unread`, `.deleted`).  
- **`completion`**: Provides the result of the operation, returning either a success flag (`Bool`) or error details once the process is complete.  
###

#### 3.1 Get Inbox Count  

Retrieves the total number of inbox items for the user.  
The response provides detailed counts, including total, unread, read, and deleted messages.  

```swift
EIQNotificaManager.shared.getCount { result in
    print("Total: \(count?.totalCount ?? 0)")
    print("Unread: \(count?.unreadCount ?? 0)")
    print("Read: \(count?.readCount ?? 0)")
    print("Deleted: \(count?.deletedCount ?? 0)")
}
```

With these parameters:  
- **`completion`**: Returns an `EIQInboxCount` model or error information when the operation completes.  

The `EIQInboxCount` model includes:  
- **`totalCount`**: Total number of inbox items.  
- **`unreadCount`**: Number of unread inbox items.  
- **`readCount`**: Number of read inbox items.  
- **`deletedCount`**: Number of deleted inbox items.  

#### 3.2 Delete All Inbox Items

Deletes all inbox items for the user. Once executed, all messages in the inbox (read, unread, and deleted) will be permanently removed.

```swift
EIQNotificaManager.shared.deleteAll { result in
    print("All inbox items deleted: \(success)")
}
```

With these parameters:  
- **`completion`**: Returns a success flag (`Bool`) or error information when the operation completes.  

## License

EIQNotifica is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
