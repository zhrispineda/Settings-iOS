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
    
    var body: some View {
        CustomList(title: "Game Center") {
            Section(content: {
                // TODO: Present sheet when toggled if signed out
                Toggle("Game Center", isOn: $gameCenterEnabled)
            }, footer: {
                Text("A social gaming service that lets you interact with friends, track, and compare scores and achievements, challenge other players, and compete in multiplayer games.\n\n[See how your data is managed...](#)")
            })
        }
    }
}

#Preview {
    GameCenterView()
}
