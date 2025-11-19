//
//  DebugSettingsView.swift
//  Preferences
//
//  Settings > Debug > Debug Settings
//

import SwiftUI

struct DebugSettingsView: View {
    @State private var debugOverlays = false
    @State private var faceTimeDebugging = false
    @State private var messageDebugging = false
    @State private var continuityDebugging = false
    @State private var accessoryDebugging = false
    
    var body: some View {
        CustomList(title: "Debug Settings", topPadding: true) {
            Section("Debug Overlays") {
                Toggle("List Controller and Cell Class Names", isOn: $debugOverlays)
            }
            
            Section {
                Toggle("Facetime Debugging", isOn: $faceTimeDebugging)
                Toggle("iMessage Debugging", isOn: $messageDebugging)
                Toggle("Facetime Debugging", isOn: $continuityDebugging)
                Toggle("Accessory Debugging", isOn: $accessoryDebugging)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DebugSettingsView()
    }
}
