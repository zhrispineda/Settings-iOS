//
//  KeyboardView.swift
//  Preferences
//
//  Settings > General > Keyboard
//

import SwiftUI

struct KeyboardView: View {
    var body: some View {
        BundleControllerView(
            "KeyboardSettings",
            controller: "KeyboardController",
            title: "KEYBOARDS_SHORT".localized(
                path: "/System/Library/PreferenceBundles/KeyboardSettings.bundle",
                table: "Keyboard"
            )
        )
    }
}

#Preview {
    NavigationStack {
        KeyboardView()
    }
}
