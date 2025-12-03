//
//  SoundsAndHapticsView.swift
//  Preferences
//
//  Settings > [Sounds & Haptics/Sounds]
//

import SwiftUI

struct SoundsAndHapticsView: View {
    var body: some View {
        ControllerBridgeView(
            "/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework/SoundsAndHapticsSettings",
            controller: "SHSSoundsPrefController",
            title: UIDevice.iPhone ? "Sounds & Haptics" : "Sounds"
        )
    }
}

#Preview {
    NavigationStack {
        SoundsAndHapticsView()
    }
}
