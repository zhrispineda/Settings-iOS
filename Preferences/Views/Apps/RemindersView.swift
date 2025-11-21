//
//  RemindersView.swift
//  Preferences
//
//  Settings > Apps > Reminders
//

import SwiftUI

struct RemindersView: View {
    var body: some View {
        BundleControllerView(
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
