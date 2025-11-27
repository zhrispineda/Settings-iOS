//
//  DebugSettingsView.swift
//  Preferences
//
//  Settings > Debug > Debug Settings
//

import SwiftUI

struct DebugSettingsView: View {
    @Environment(PrimarySettingsListModel.self) private var model
    
    var body: some View {
        @Bindable var model = model
        
        CustomList(title: "Debug Settings", topPadding: true) {
            Section("Debug Overlays") {
                Toggle("List Controller and Cell Class Names", isOn: $model.showingDebugOverlays)
            }
            
            Section {
                Toggle("Facetime Debugging", isOn: $model.showingFaceTimeDebugging.animation())
                Toggle("iMessage Debugging", isOn: $model.showingMessageDebugging.animation())
                Toggle("Facetime Debugging", isOn: $model.showingContinuityDebugging.animation())
                Toggle("Accessory Developer", isOn: $model.showingAccessoryDeveloper.animation())
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
