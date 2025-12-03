//
//  PasswordsView.swift
//  Preferences
//
//  Settings > Apps > Passwords
//

import SwiftUI

struct PasswordsView: View {
    var body: some View {
        ControllerBridgeView(
            "PasswordsSettings",
            controller: "PMSettingsController",
            title: "Passwords (app name)".localized(path: "/System/Library/PreferenceBundles/PasswordsSettings.bundle")
        )
    }
}

#Preview {
    NavigationStack {
        PasswordsView()
    }
}
