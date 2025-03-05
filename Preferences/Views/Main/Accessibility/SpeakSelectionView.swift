//
//  SpeakSelectionView.swift
//  Preferences
//
//  Settings > Accessibility > Speak Selection
//

import SwiftUI

struct SpeakSelectionView: View {
    // Variables
    @State private var speakSelectionEnabled = false
    @State private var speakingRate = 0.5
    let table = "SpeechSettings"
    let accTable = "Accessibility"
    
    var body: some View {
        CustomList(title: "QUICK_SPEAK_TITLE".localize(table: table)) {
            Section {
                Toggle("QUICK_SPEAK_TITLE".localize(table: table), isOn: $speakSelectionEnabled.animation())
            } footer: {
                Text("QuickSpeakGeneralFooterText", tableName: table)
            }
            
            Section {
                NavigationLink("PRONUNCIATION_DICTIONARY".localize(table: table), destination: PronunciationsView())
            }
            
            if speakSelectionEnabled {
                Section {
                    CustomNavigationLink("HIGHLIGHT_WORD".localize(table: table), status: "OFF".localize(table: accTable), destination: HighlightContentView())
                } footer: {
                    Text("QuickSpeakWordHighlightFooterText", tableName: table)
                }
                
                Section {
                    NavigationLink("QUICKSPEAK_VOICES".localize(table: table), destination: SpeakSelectionVoicesView())
                }
                
                Section {
                    Group {
                        Slider(value: $speakingRate,
                               in: 0.0...1.0,
                               minimumValueLabel: Image(systemName: "tortoise.fill"),
                               maximumValueLabel: Image(systemName: "hare.fill"),
                               label: { Text("QUICK_SPEAK_RATE", tableName: table) }
                        )
                    }
                    .imageScale(.large)
                    .foregroundStyle(.secondary)
                } header: {
                    Text("QUICK_SPEAK_RATE", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SpeakSelectionView()
    }
}
