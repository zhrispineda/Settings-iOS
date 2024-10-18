//
//  GameControllerView.swift
//  Preferences
//
//  Settings > Game Controller
//

import SwiftUI

struct GameControllerView: View {
    // Variables
    let table = "GameControlleriOSSettings"
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: "gamecontroller.fill")
                .font(.largeTitle)
            Text("NO_CONTROLLER_CONNECTED", tableName: table)
            Spacer()
        }
    }
}

#Preview {
    GameControllerView()
}
