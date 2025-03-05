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
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "LIVE_SPEECH".localize(table: table)) {
            Section {
                Toggle("LIVE_SPEECH".localize(table: table), isOn: $liveSpeechEnabled)
            } footer: {
                if UIDevice.HomeButtonCapability {
                    Text("LIVE_SPEECH_TRIPLE_CLICK_EXPLANATION", tableName: table) + Text("\n[\("LiveSpeechWhatsNewLink".localize(table: table))](#)")
                } else if !UIDevice.HomeButtonCapability {
                    Text("LIVE_SPEECH_TRIPLE_CLICK_EXPLANATION_NHB", tableName: table) + Text("\n[\("LiveSpeechWhatsNewLink".localize(table: table))](#)")
                }
            }
            
            Section {
                if UIDevice.IsSimulator {
                    NavigationLink("LIVE_SPEECH_PHRASES".localize(table: table)) {
                        CustomList(title: "LIVE_SPEECH_PHRASES".localize(table: table)) {}
                    }
                } else {
                    NavigationLink("LIVE_SPEECH_PHRASES".localize(table: table), destination: PhrasesView())
                }
            } footer: {
                Text("LIVE_SPEECH_ADD_FAVORITE_PHRASE_FOOTER", tableName: table)
            }
            
            Section {
                CustomNavigationLink("English (US)", status: "Siri Voice 4 (United States)", destination: SpeakSelectionVoiceDetailView(title: "English"))
            } header: {
                Text("LIVE_SPEECH_VOICES", tableName: table)
            } footer: {
                Text("LIVE_SPEECH_VOICES_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LiveSpeechView()
    }
}
