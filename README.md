# Settings-iOS
A **work-in-progress** SwiftUI recreation of the iOS & iPadOS Settings app (Preferences.app).

> [!NOTE]  
> This project is focused on the latest public releases of iOS, iPadOS, and Xcode. Use an older branch to use older versions.

## Information
- Recreation of Apple's Settings app for iOS and iPadOS 26.1 (23B85).
- All features within the app are only simulations and have no effect on the device outside of the app.
- Features available within the app vary depending on the device model and its capabilities to make this recreation as accurate as possible.
- In some panes, the app will load actual preference bundles internally using a view controller bridge (functionality and stability may vary).
- Previous versions are available as their own branches in this repository, going as far back as 17.4.

> [!CAUTION]
> This project uses some private APIs that are not intended or supported for public use for demonstration purposes only.
>
> **Do not reuse any code in this project that has been identified as relying on private methods.**

## Preview

<details open>
<summary>iOS 26</summary>
  
![An image displaying the project's Settings app in the canvas for iPhone, matching the updated appearance of iOS 26.](Assets/26Phone.png)

</details>

<details open>
<summary>iPadOS 26</summary>
  
![An image displaying the project's Settings app in the canvas for iPad, matching the updated appearance of iPadOS 26.](Assets/26Pad.png)

</details>

## Usage
Open the project in Xcode and run with either a Simulator instance or a physical device running iOS or iPadOS with Developer Mode enabled as a destination.

> [!IMPORTANT]  
> You may need to change the bundle identifier of the app to be able to sign it with Xcode for use on a physical device.

To switch between the simulator and physical-like layout of Settings in Simulator or Preview, modify the `forcePhysical` variable on line 13 of `PrimarySettingsListModel.swift` under `Preferences/Models`.

As this is a project for learning Swift and SwiftUI, feel free to download or fork and modify the project for your own personal use.

## Disclaimers
- All assets including icons and images are not my own in any way.
- This app is a personal, educational recreation of Apple's apps and designs, created in appreciation of the teams who built them.
- Feel free to look through the commit history to see the project evolve from a single view to its current state.
- If you have any questions or feedback, please contact me through the options listed on my profile.

## Other Settings Projects
- **macOS System Settings** https://github.com/zhrispineda/System-Settings
- **visionOS Settings** https://github.com/zhrispineda/Settings-visionOS
- **watchOS Settings** https://github.com/zhrispineda/Settings-watchOS
- **tvOS Settings** https://github.com/zhrispineda/Settings-tvOS
