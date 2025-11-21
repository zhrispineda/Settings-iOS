//
//  HealthView.swift
//  Preferences
//
//  Settings > Apps > Health
//

import SwiftUI

struct HealthView: View {
    var body: some View {
        BundleControllerView(
            "HealthSettings",
            controller: "HKHealthSettingsController",
            title: "HEALTH".localized(
                path: "/System/Library/PrivateFrameworks/HealthUI.framework",
                table: "HealthUI-Localizable"
            )
        )
    }
}

#Preview {
    NavigationStack {
        HealthView()
    }
}
