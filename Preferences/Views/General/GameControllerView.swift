//
//  GameControllerView.swift
//  Preferences
//
//  Settings > Game Controller
//

import SwiftUI

struct GameControllerView: View {
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: "gamecontroller.fill")
                .font(.largeTitle)
            Text("Connect a controller to continue.")
            Spacer()
        }
    }
}

#Preview {
    GameControllerView()
}
