//
//  HotCornersDetailView.swift
//  Preferences
//
//  Settings > Accessibility > Touch > AssistiveTouch > Hot Corners > [Option]
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
            Picker("\nSYSTEMHEADING", selection: $selected) {
                ForEach(systemOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            
            Picker("ACCESSIBILITY", selection: $selected) {
                ForEach(accessibilityOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            
            Picker("SCROLLHEADING", selection: $selected) {
                ForEach(scrollGestures, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
            
            Picker("DWELLHEADING", selection: $selected) {
                ForEach(dwellControls, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        HotCornersDetailView()
    }
}
