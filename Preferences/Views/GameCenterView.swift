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
            Section {
                Toggle("Game Center", isOn: $gameCenterEnabled)
                    .sheet(isPresented: $gameCenterEnabled, content: {
                        AppleAccountSignInView()
                    })
            } footer: {
                Text("A social gaming service that lets you interact with friends, track, and compare scores and achievements, challenge other players, and compete in multiplayer games.\n\n[See how your data is managed...](#)")
            }
        }
    }
}

#Preview {
    GameCenterView()
}
