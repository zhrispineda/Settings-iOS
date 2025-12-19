//
//  InternalSettingsView.swift
//  Preferences
//

import SwiftUI

struct InternalSettingsView: View {
    var body: some View {
        ControllerBridgeView(
            "/AppleInternal/Library/PreferenceBundles/Internal Settings.bundle/Internal Settings",
            controller: "InternalSettingsController",
            title: "Internal Settings"
        )
    }
}

#Preview {
    NavigationStack {
        InternalSettingsView()
    }
}
