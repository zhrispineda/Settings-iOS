# Settings-iOS
A **work-in-progress** SwiftUI recreation of the iOS & iPadOS Settings app (Preferences.app).

## Information
- This personal project is a recreation of Apple's Settings app for iOS and iPadOS 18.5 **Release** (22F76).
- All features within the app are only simulations and have no effect on the device outside of the app.
- Features available within the app vary depending on the device model and its capabilities to make this recreation as accurate as possible.
- In some panes, the app will load actual preference bundles internally using a view controller bridge (functionality may vary).
- Previous versions are available as their own branches in this repository, going as far back as 17.4.

## Examples
Physical device mode:

![A GIF displaying the project‘s Settings app on different devices including a Dynamic Island iPhone, iPhone with Touch ID, and an 11-inch iPad. It is similar to the Settings layout of a physical device.](Assets/SettingsPhysical.gif)

Simulator instance mode:

![A GIF displaying the project‘s Settings app on different devices including a Dynamic Island iPhone, iPhone with Touch ID, and an 11-inch iPad. It is similar to the Settings layout of a Simulator instance.](Assets/SettingsSimulator.gif)

## Usage
Open the project in Xcode and run with either a Simulator instance or a physical device running iOS or iPadOS with Developer Mode enabled as a destination.

> [!IMPORTANT]  
> You may need to change the bundle identifier of the app to be able to sign it in Xcode for use on a physical device.

To switch between the simulator and physical-like layout of Settings in Simulator or Preview, modify the `forcePhysical` variable on line 12 of `SettingsModel.swift` under `Preferences/Models`.

As this is a project for learning Swift and SwiftUI, feel free to download or fork and modify the project for your own personal use.

## Disclaimers
- All assets such as icons and images are not my own in any way.
- This app is a recreation of Apple's own apps and designs for educational purposes only.
- Feel free to look through the commit history to see the project evolve from a single view to its current state.
- If you have any questions or feedback, please contact me through the options listed on my GitHub profile.

## Other Settings Projects
- **macOS System Settings** https://github.com/zhrispineda/System-Settings
- **visionOS Settings** https://github.com/zhrispineda/Settings-visionOS
- **watchOS Settings** https://github.com/zhrispineda/Settings-watchOS
