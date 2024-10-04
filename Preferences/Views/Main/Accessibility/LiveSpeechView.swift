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
            Section {
                Toggle("Live Speech", isOn: $liveSpeechEnabled)
            } footer: {
                Text("Live Speech speaks aloud what you type using the speaker, and in calls. Triple-click the \(UIDevice.HomeButtonCapability ? "Home" : "Side") button to show Live Speech.\n[What‘s new in Live Speech...](#)")
            }
            
            Section {
                if UIDevice.IsSimulator {
                    NavigationLink("Phrases") {
                        CustomList(title: "Phrases") {}
                    }
                } else {
                    NavigationLink("Phrases", destination: PhrasesView())
                }
            } footer: {
                Text("Create phrases that you can quickly speak with Live Speech.")
            }
            
            Section {
                CustomNavigationLink(title: "English (US)", status: "Siri Voice 4 (United States)", destination: SpeakSelectionVoiceDetailView(title: "English"))
            } header: {
                Text("Voices")
            } footer: {
                Text("Live Speech uses Keyboards to determine available voices.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        LiveSpeechView()
    }
}
