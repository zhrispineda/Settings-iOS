#  Settings-iOS
A **work-in-progress** SwiftUI recreation of the iOS & iPadOS Settings app.

## Information
- This personal project is a recreation of Apple's Settings app for iOS and iPadOS 18.0 **Release** (22A3354).
- All features within the app are only simulations and have no effect on the device outside of the app.
- Features in the app vary based on the device model and its capabilities to make it as accurate as possible.

## Examples
Physical device mode:

![A GIF displaying the project‘s Settings app on different devices including a Dynamic Island iPhone, iPhone with Touch ID, and an 11-inch iPad.](Assets/SettingsPhysical.gif)

Simulator instance mode:

![A GIF displaying the project‘s Settings app on different devices including a Dynamic Island iPhone, iPhone with Touch ID, and an 11-inch iPad.](Assets/SettingsSimulator.gif)

## Usage
Open the project in Xcode and run with either a Simulator instance or a physical device with Developer Mode enabled as a destination.

To switch between the simulator or physical-like view of Settings in Simulator or Preview, modify the `forcePhysical` variable on line 11 of `SettingsModel.swift` under Preferences/Models.

As this is a personal project for learning Swift and SwiftUI, feel free to download and modify the project for your own personal purposes.

> [!IMPORTANT]
> 
> This project is being worked on using **Xcode 16 beta** and **Swift 6**. To use this project in Xcode 15, change the version of Swift to 5:
>
> (Top of project sidebar) `Preferences` > Under `TARGETS` > `Preferences` > `Build Settings` > (Scroll to bottom) `Swift Compiler - Language` > `Swift Language Version` > Change the value `Swift 6` to `Swift 5`
>
> Delete either AppIcon asset (Dark or Tinted) as Xcode 15 does not support dark and tinted icons.
>

## Disclaimers
- All assets such as icons and images are not my own in any way.
- This app is a recreation of Apple's own apps and designs for learning purposes only.
- Feel free to look through the commit history to see the project evolve from a single view to its current state.
- If you have any questions or feedback, please contact me through the options listed on my GitHub profile.

## Other Settings Projects
- **visionOS Settings** https://github.com/zhrispineda/Settings-visionOS
- **watchOS Settings** https://github.com/zhrispineda/Settings-watchOS
