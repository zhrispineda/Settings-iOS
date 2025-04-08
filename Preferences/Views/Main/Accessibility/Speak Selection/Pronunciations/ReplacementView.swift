//
//  ReplacementView.swift
//  Preferences
//
//  Settings > Accessibility > Spoken Content > Pronunciations > +
//

import SwiftUI
import AVFoundation

struct ReplacementView: View {
    // Variables
    let synthesizer = AVSpeechSynthesizer()
    @State private var phraseText = String()
    @State private var substitutionText = String()
    @State private var ignoreCaseEnabled = true
    @State private var applyAllAppsEnabled = true
    
    let options = ["Home Screen & App Library", "Calendar", "Contacts", "Files", "Health", "Maps", "Messages", "News", "Photos", "Reminders", "Safari", "Settings", "Shortcuts", "Siri", "Wallet", "Watch"]
    @State private var selected: [String] = []
    let table = "VoiceOverSettings"
    
    var body: some View {
        CustomList(title: "EDIT_PRONUNCIATION".localize(table: table)) {
            Section {
                HStack {
                    Text("PRONUNCIATION_ORIGINAL_STRING".localize(table: table) + "\t\t")
                    Spacer()
                    TextField("", text: $phraseText)
                }
                HStack {
                    Text("PRONUNCIATION_REPLACEMENT_STRING", tableName: table)
                    TextField("", text: $substitutionText)
                    Spacer()
                    Button {} label: {
                        Image(systemName: "mic.circle")
                            .font(.title)
                            .fontWeight(.ultraLight)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.accent)
                    .disabled(phraseText.isEmpty)
                }
            } footer: {
                Text("PRONUNCIATION_DICTATE_HELP", tableName: table)
            }
            
            Section {
                CustomNavigationLink("PRONUNCIATION_LANGUAGE".localize(table: table), status: "English (US)", destination: PronunciationLanguagesView())
                CustomNavigationLink("SPEECH_VOICES".localize(table: table), status: "VO_MODIFIER_KEY_ALL_OPTIONS".localize(table: table), destination: PronunciationVoicesView())
                Toggle("PRONUNCIATION_IGNORE_CASE".localize(table: table), isOn: $ignoreCaseEnabled)
                Toggle("APPLIES_TO".localize(table: table), isOn: $applyAllAppsEnabled.animation())
            }
            
            if !applyAllAppsEnabled {
                Section {
                    ForEach(options, id: \.self) { option in
                        Button {
                            if let index = selected.firstIndex(of: option) {
                                selected.remove(at: index)
                            } else {
                                selected.append(option)
                            }
                        } label: {
                            HStack {
                                SettingsLabel(icon: "apple\(option)", id: option)
                                    .foregroundStyle(.primary)
                                Spacer()
                                Image(systemName: "\(selected.contains(option) ? "checkmark" : "")")
                            }
                        }
                    }
                } header: {
                    Text("PRONUNCIATION_APPS_TITLE", tableName: table)
                }
            }
        }
        .toolbar {
            Button("PLAY".localize(table: "Accessibility"), action: speakText)
                .disabled(substitutionText.isEmpty)
        }
    }
    
    func speakText() {
        let utterance = AVSpeechUtterance(string: substitutionText)
        let voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.voice = voice
        synthesizer.speak(utterance)
    }
}

#Preview {
    NavigationStack {
        ReplacementView()
    }
}
