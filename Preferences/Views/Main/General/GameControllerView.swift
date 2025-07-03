//
//  GameControllerView.swift
//  Preferences
//
//  Settings > General > Game Controller
//

import SwiftUI

struct GameControllerView: View {
    let path = "/System/Library/PreferenceBundles/GameControlleriOSSettings.bundle"
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: "gamecontroller.fill")
                .font(.largeTitle)
            Text("NO_CONTROLLER_CONNECTED".localized(path: path))
            Spacer()
        }
    }
}

#Preview {
    GameControllerView()
}
