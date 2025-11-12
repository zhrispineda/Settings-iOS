//
//  ControlCenterView.swift
//  Preferences
//
//  Settings > Control Center
//

import SwiftUI

struct ControlCenterView: View {
    var body: some View {
        BundleControllerView(
            "ControlCenterSettings",
            controller: "ControlCenterSettingsViewController",
            title: "Control Center"
        )
    }
}

#Preview {
    ControlCenterView()
}
