#  Settings-iOS
SwiftUI (work-in-progress) recreation of the iOS & iPadOS Settings app.

## Examples
![A GIF displaying the project's Settings app on different devices including a Dynamic Island iPhone, iPhone SE, and 11-inch iPad Pro.](Assets/Settings.gif)

## Information
- This personal project is a recreation of Apple's current and default Settings app for iPhone and iPad on **(Simulator.app) and iOS/iPadOS** using 17.5 (21F79).
- All features within the app are only simulations and have no effect on the device outside of the app.
- Most views are complete, but lack features such as saving data, including basic variables, for now.
- Since this project is based off of the Simulator and not a physical iPhone or iPad yet, aspects such as simulated controls and views for wireless settings, are missing or incomplete for now, and will be added or completed in the future.
- Currently, this project does not make use of Swift Packages, UIKit, Storyboards, or Objective-C, and is purely Swift & SwiftUI.

## Usage
Open the project in Xcode and run with either a Simulator instance running iOS/iPadOS or a physical iPhone/iPad with Developer Mode enabled as a destination.
To switch between the simulator or physical-like view of Settings, modify the `isSimulator` variable on line 12 of `SettingsModel.swift` under Preferences/Models.

As this is a personal project for learning Swift and SwiftUI, feel free to fork, explore, and make the project your own for any personal purpose!

## Contributing
Contributions such as pull requests that help make the app more accurate and better optimized are always welcome.

Issues are also encouraged to raise awareness to certain issues, inconsistencies, or questions about the project.

## To Do
- Make use of NSUserDefaults for saving and loading basic data.
- Make use of Bindings and a Model to keep persistent data across views and app sessions.
- Work on missing sheet views such as ones opened through links.
- Implement simulated functionality of radios and other physical-device-only options.

## Disclaimers
- This app is a recreation of one of Apple's own apps and its designs.
- All assets such as icons including those of Apple's and the Bluetooth symbol are not my own in any way.
- Feel free to look through the commit history to see the project evolve from a single view to its current state.
- Some code may not be best practice and may not be optimal.

