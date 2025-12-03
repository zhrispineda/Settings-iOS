//
//  RemindersView.swift
//  Preferences
//
//  Settings > Apps > Reminders
//

import SwiftUI

struct RemindersView: View {
    var body: some View {
        ControllerBridgeView(
            "RemindersSettings",
            controller: "REMSettingsController",
            title: "Reminders".localized(path: "/System/Library/PreferenceBundles/RemindersSettings.bundle")
        )
    }
}

#Preview {
    NavigationStack {
        RemindersView()
    }
}
