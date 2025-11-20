//
//  SafariView.swift
//  Preferences
//
//  Settings > Apps > Safari
//

import SwiftUI

struct SafariView: View {
    var body: some View {
        BundleControllerView(
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
