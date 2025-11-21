//
//  ShortcutsView.swift
//  Preferences
//
//  Settings > Apps > Shortcuts
//

import SwiftUI

struct ShortcutsView: View {
    var body: some View {
        BundleControllerView(
            "ShortcutsSettings",
            controller: "WFShortcutsSettingsController",
            title: "Shortcuts".localized(path: "/System/Library/PreferenceBundles/ShortcutsSettings.bundle")
        )
    }
}

#Preview {
    NavigationStack {
        ShortcutsView()
    }
}
