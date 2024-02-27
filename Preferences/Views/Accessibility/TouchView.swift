//
//  TouchView.swift
//  Preferences
//
//  Settings > Accessibility > Touch
//

import SwiftUI

struct TouchView: View {
    // Variables
    @State private var shakeUndoEnabled = true
    
    var body: some View {
        CustomList(title: "Touch") {
            Section(content: {
                CustomNavigationLink(title: "AssistiveTouch", status: "Off", destination: AssistiveTouchView())
            }, footer: {
                Text(DeviceInfo().isPhone ? "AssistiveTouchInstructionalTextFormat_IPHONE" : "AssistiveTouchInstructionalTextFormat_IPAD")
            })
            
            Section(content: {
                Toggle("Shake to Undo", isOn: $shakeUndoEnabled)
            }, footer: {
                Text("If you tend to shake your \(DeviceInfo().model) by accident, you can disable Shake to Undo to prevent the Undo alert from appearing.")
            })
        }
    }
}

#Preview {
    NavigationStack {
        TouchView()
    }
}
