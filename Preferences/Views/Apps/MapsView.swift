//
//  MapsView.swift
//  Preferences
//
//  Settings > Apps > Maps
//

import SwiftUI

struct MapsView: View {
    var body: some View {
        ControllerBridgeView(
            "MapsSettings",
            controller: "MapsSettingsController",
            title: "Maps [Settings]".localized(path: "/System/Library/PreferenceBundles/MapsSettings.bundle")
        )
    }
}

#Preview {
    NavigationStack {
        MapsView()
    }
}
