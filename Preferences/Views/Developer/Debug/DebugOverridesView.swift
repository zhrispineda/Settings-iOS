//
//  DebugOverridesView.swift
//  Preferences
//
//  Settings > Debug > Sidebar Content Overrides
//

import SwiftUI

struct DebugOverridesView: View {
    @Environment(PrimarySettingsListModel.self) private var model
    
    var body: some View {
        @Bindable var model = model
        
        CustomList(title: "Sidebar Content Overrides") {
            Toggle("Facetime Debugging", isOn: $model.showingFaceTimeDebugging.animation())
            Toggle("iMessage Debugging", isOn: $model.showingMessageDebugging.animation())
            Toggle("Facetime Debugging", isOn: $model.showingContinuityDebugging.animation())
            Toggle("Accessory Developer", isOn: $model.showingAccessoryDeveloper.animation())
        }
    }
}

#Preview {
    DebugOverridesView()
        .environment(PrimarySettingsListModel())
}
