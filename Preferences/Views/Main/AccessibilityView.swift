//
//  AccessibilityView.swift
//  Preferences
//
//  Settings > Accessibility
//

import SwiftUI

struct AccessibilityView: View {
    var body: some View {
        ControllerBridgeView(
            "AccessibilitySettings",
            controller: "AccessibilitySettingsController",
            title: "Accessibility"
        )
    }
}

#Preview {
    NavigationStack {
        AccessibilityView()
    }
}
