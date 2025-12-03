//
//  ControlCenterView.swift
//  Preferences
//
//  Settings > Control Center
//

import SwiftUI

struct ControlCenterView: View {
    var body: some View {
        ControllerBridgeView(
            "ControlCenterSettings",
            controller: "ControlCenterSettingsViewController",
            title: "Control Center"
        )
    }
}

#Preview {
    ControlCenterView()
}
