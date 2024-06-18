#  Settings-iOS
SwiftUI **(work-in-progress)** recreation of the iOS & iPadOS Settings app.

**IMPORTANT:** This project is being worked on using **Xcode 16 beta** and **Swift 6.0**. To use this project on Xcode 15, change the version of Swift to 5.0:

(Top of project sidebar) `Preferences` > `TARGETS` > `Preferences` > `Build Settings` > (Scroll to bottom) `Swift Compiler - Language` > `Swift Language Version` > Change the value `Swift 6` to `Swift 5`

## Examples
- Physical-like:

![A GIF displaying the project's Settings app on different devices including a Dynamic Island iPhone, iPhone with Touch ID, and an 11-inch iPad.](Assets/SettingsPhysical.gif)

- Simulator:

![A GIF displaying the project's Settings app on different devices including a Dynamic Island iPhone, iPhone with Touch ID, and an 11-inch iPad.](Assets/SettingsSimulator.gif)

## Information
- This personal project is a recreation of Apple's current and default Settings app for iPhone and iPad on **Simulator and iOS/iPadOS** 18.0 **beta 1** (22A5282m).
- All features within the app are only simulations and have no effect on the device outside of the app.
- Aspects such as simulated controls and some views are incomplete for now.

## Usage
Open the project in Xcode and run with either a Simulator instance running iOS/iPadOS or a physical iPhone/iPad with Developer Mode enabled as a destination.

To switch between the simulator or physical-like view of Settings, modify the `isSimulator` variable on line 12 of `SettingsModel.swift` under Preferences/Models.

As this is a personal project for learning Swift and SwiftUI, feel free to download and modify the project for your own personal purposes.

## To Do
- Basic data saving and retrieval.
- Complete missing views.
- Implement simulated functionality of many missing features.

## Disclaimers
- All assets such as icons and images are not my own in any way.
- This app is a recreation of Apple's own apps and designs for learning purposes only.
- Feel free to look through the commit history to see the project evolve from a single view to its current state.

## Other Settings Projects
- **visionOS Settings** https://github.com/zhrispineda/Settings-visionOS
- **watchOS Settings** https://github.com/zhrispineda/Settings-watchOS
