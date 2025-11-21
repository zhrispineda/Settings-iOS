//
//  AccessoryDeveloperView.swift
//  Preferences
//
//  Settings > Accessory Developer
//

import SwiftUI

struct AccessoryDeveloperView: View {
    var body: some View {
        BundleControllerView(
            "AccessoryDeveloperSettings",
            controller: "AccessoryDeveloperSettingsController",
            title: "Accessory Developer"
        )
    }
}

#Preview {
    NavigationStack {
        AccessoryDeveloperView()
    }
}
