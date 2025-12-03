//
//  GameCenterView.swift
//  Preferences
//
//  Settings > Game Center
//

import SwiftUI

struct GameCenterView: View {
    var body: some View {
        ControllerBridgeView(
            "/System/Library/PrivateFrameworks/GameCenterUI.framework/GameCenterUI",
            controller: "GameCenterUI.SettingsContainerViewController",
            title: "Game Center"
        )
    }
}

#Preview {
    NavigationStack {
        GameCenterView()
    }
}
