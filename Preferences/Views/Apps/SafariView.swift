//
//  SafariView.swift
//  Preferences
//
//  Settings > Apps > Safari
//

import SwiftUI

struct SafariView: View {
    var body: some View {
        ControllerBridgeView(
            "MobileSafariSettings",
            controller: "SafariSettingsController",
            title: "Safari"
        )
    }
}

#Preview {
    NavigationStack {
        SafariView()
    }
}
