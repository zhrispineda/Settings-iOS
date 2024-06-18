//
//  StickyKeysView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards > Sticky Keys
//

import SwiftUI

struct StickyKeysView: View {
    // Variables
    @State private var stickyKeysEnabled = false
    @State private var toggleWithShiftKey = false
    @State private var soundEnabled = true
    
    var body: some View {
        CustomList(title: "Sticky Keys") {
            Section {
                Toggle("Sticky Keys", isOn: $stickyKeysEnabled)
            } footer: {
                Text("Sticky Keys allows modifier keys to be set without having to hold the key down.")
            }
            
            Section {
                Toggle("Toggle With Shift Key", isOn: $toggleWithShiftKey)
            } footer: {
                Text("Press the Shift key five times to toggle Sticky Keys.")
            }
            
            Section {
                Toggle("Sound", isOn: $soundEnabled)
            } footer: {
                Text("Play a sound when a modifier key is set.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        StickyKeysView()
    }
}
