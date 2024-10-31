//
//  GameCenterView.swift
//  Preferences
//
//  Settings > Game Center
//

import SwiftUI

struct GameCenterView: View {
    // Variables
    @State private var gameCenterEnabled = false
    let table = "GameCenterUICore"
    
    var body: some View {
        CustomList(title: "GAME_CENTER".localize(table: table)) {
            Section {
                Toggle("GAME_CENTER".localize(table: table), isOn: $gameCenterEnabled)
                    .sheet(isPresented: $gameCenterEnabled) {
                        AppleAccountSignInView()
                    }
            } footer: {
                Text(.init("PLAYER_CARD_GAMECENTER_TOGGLE_OFF_FOOTER".localize(table: table, "[\("See how your data is managed...".localize(table: table))](#)")))
            }
        }
    }
}

#Preview {
    NavigationStack {
        GameCenterView()
    }
}
