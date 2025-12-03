//
//  AccessoryDeveloperView.swift
//  Preferences
//
//  Settings > Accessory Developer
//

import SwiftUI

struct AccessoryDeveloperView: View {
    var body: some View {
        ControllerBridgeView(
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
