//
//  LiveSpeechView.swift
//  Preferences
//
//  Settings > Accessibility > Live Speech
//

import SwiftUI

struct LiveSpeechView: View {
    // Variables
    @State private var liveSpeechEnabled = false
    
    var body: some View {
        CustomList(title: "Live Speech") {
            Section(content: {
                Toggle("Live Speech", isOn: $liveSpeechEnabled)
            }, footer: {
                Text("Triple-click the \(DeviceInfo().hasHomeButton ? "home" : "side") button to show Live Speech.")
            })
            
            Section {
                NavigationLink("Favorite Phrases", destination: FavoritePhrasesView())
            }
            
            Section(content: {
                CustomNavigationLink(title: "English (US)", status: "Samantha", destination: SpeakSelectionVoiceDetailView(title: "English"))
            }, header: {
                Text("Voices")
            }, footer: {
                Text("Live Speech uses Keyboards to determine available voices.")
            })
        }
    }
}

#Preview {
    NavigationStack {
        LiveSpeechView()
    }
}
