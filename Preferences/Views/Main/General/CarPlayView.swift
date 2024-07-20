//
//  CarPlayView.swift
//  Preferences
//
//  Settings > General > CarPlay
//

import SwiftUI

struct CarPlayView: View {
    var body: some View {
        CustomList(title: "CarPlay") {
            Section {
                Image("SiriWheel")
                    .resizable()
                    .scaledToFit()
                    .listRowInsets(EdgeInsets())
            }
            
            Section {} footer: {
                Text("If your car supports wireless CarPlay, press and hold the voice control button on your steering wheel to start CarPlay setup.")
            }
            
            Section {} header: {
                HStack {
                    Text("Available Cars")
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CarPlayView()
    }
}
