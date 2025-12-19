//
//  CarrierSettingsView.swift
//  Preferences
//

import SwiftUI

struct CarrierSettingsView: View {
    var body: some View {
        ControllerBridgeView(
            "/AppleInternal/Library/PreferenceBundles/Carrier Settings.bundle/Carrier Settings",
            controller: "CSCarrierSettingsController",
            title: "Carrier Settings"
        )
    }
}

#Preview {
    CarrierSettingsView()
}
