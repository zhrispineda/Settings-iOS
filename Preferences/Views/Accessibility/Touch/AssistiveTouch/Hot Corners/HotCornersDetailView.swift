//
//  HotCornersDetailView.swift
//  Preferences
//
//  Settings > Accessibility > Touch > AssistiveTouch > Hot Corners
//

import SwiftUI

struct HotCornersDetailView: View {
    // Variables
    var title = String()
    @State private var selected = String()
    let systemOptions = ["NONE", "Open Menu", "Analytics", "App Switcher", "Camera", "Control Center", "Double Tap", "Hold and Drag", "Home", "Lock Rotation", "Lock Screen", "Long Press", "Move Menu", "Notification Center", "Pinch", "Pinch and Rotate", "Restart", "Rotate", "Screenshot", "Shake", "Siri", "Spotlight", "Volume Up", "Volume Down"]
    let accessibilityOptions = ["Accessibility Shortcut", "Control Nearby Devices", "Dim Flashing Lights", "Live Speech", "Speak Screen"]
    let scrollGestures = ["Continuos Horizontal Scroll", "Continuous Verical Scroll", "Scroll Down", "Scroll Left", "Scroll Right", "Scroll to Bottom", "Scroll to Top", "Scroll Up"]
    let dwellControls = ["Enable/Disable Fallback", "Move Menu", "Tap", "Toggle Pause/Resume Dwell"]
    
    var body: some View {
        CustomList(title: title) {
            Section {
                ForEach(systemOptions, id: \.self) { option in
                    Button {
                        selected = option
                    } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            Image(systemName: "\(selected == option ? "checkmark" : "")")
                        }
                    }
                }
            } header: {
                Text("\n\nSYSTEMHEADING")
            }
            
            Section {
                ForEach(accessibilityOptions, id: \.self) { option in
                    Button {
                        selected = option
                    } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            Image(systemName: "\(selected == option ? "checkmark" : "")")
                        }
                    }
                }
            } header: {
                Text("ACCESSIBILITY")
            }
            
            Section {
                ForEach(scrollGestures, id: \.self) { option in
                    Button {
                        selected = option
                    } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            Image(systemName: "\(selected == option ? "checkmark" : "")")
                        }
                    }
                }
            } header: {
                Text("SCROLLHEADING")
            }
            
            Section {
                ForEach(dwellControls, id: \.self) { option in
                    Button {
                        selected = option
                    } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            Image(systemName: "\(selected == option ? "checkmark" : "")")
                        }
                    }
                }
            } header: {
                Text("DWELLHEADING")
            }
        }
    }
}

#Preview {
    NavigationStack {
        HotCornersDetailView()
    }
}
