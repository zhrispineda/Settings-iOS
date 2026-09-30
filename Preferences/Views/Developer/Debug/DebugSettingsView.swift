//
//  DebugSettingsView.swift
//  Preferences
//
//  Settings > Debug > Preferences Debug
//

import SwiftUI

struct DebugSettingsView: View {
    @AppStorage("BridgeDebug") private var bridgeDebug = false
    @AppStorage("LegacyDebug") private var legacyDebug = false
    @Environment(PrimarySettingsListModel.self) private var model
    
    var body: some View {
        @Bindable var model = model
        
        CustomList(title: "Preferences Debug", topPadding: true) {
            Section("List Controller and Cell Class Names Overlays") {
                Toggle("Current App", isOn: $model.showingDebugOverlays)
                Toggle("Bridge (Watch.app)", isOn: $bridgeDebug)
                Toggle("Legacy Settings", isOn: $legacyDebug)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DebugSettingsView()
            .environment(PrimarySettingsListModel())
    }
}
