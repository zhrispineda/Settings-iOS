//
//  EmergencySOSView.swift
//  Preferences
//
//  Settings > Emergency SOS
//

import SwiftUI

struct EmergencySOSView: View {
    var body: some View {
        BundleControllerView(
            "SOSSettings",
            controller: "SOSSettingsController",
            title: "Emergency SOS"
        )
    }
}

#Preview {
    NavigationStack {
        EmergencySOSView()
    }
}
