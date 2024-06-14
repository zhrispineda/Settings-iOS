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
            Section {
                CustomNavigationLink(title: "AssistiveTouch", status: "Off", destination: AssistiveTouchView())
            }
            
            Section {
                Toggle("Shake to Undo", isOn: $shakeUndoEnabled)
            } footer: {
                Text("If you tend to shake your \(Device().model) by accident, you can disable Shake to Undo to prevent the Undo alert from appearing.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        TouchView()
    }
}
