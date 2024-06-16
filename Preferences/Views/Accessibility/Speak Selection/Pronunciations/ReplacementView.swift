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
    
    var body: some View {
        CustomList(title: "Replacement") {
            Section {
                HStack {
                    Text("Phrase\t\t")
                    Spacer()
                    TextField("", text: $phraseText)
                }
                HStack {
                    Text("Substitution")
                    TextField("", text: $substitutionText)
                    Spacer()
                    Button {} label: {
                        Image(systemName: "mic.circle")
                            .font(.title)
                            .fontWeight(.ultraLight)
                    }
                    .buttonStyle(.plain)
                    .disabled(phraseText.isEmpty)
                }
            } footer: {
                Text("Dictate or spell out how you want the phrase to be pronounced.")
            }
            
            Section {
                CustomNavigationLink(title: "Languages", status: "English (US)", destination: PronunciationLanguagesView())
                CustomNavigationLink(title: "Voices", status: "All", destination: PronunciationVoicesView())
                Toggle("Ignore case", isOn: $ignoreCaseEnabled)
                Toggle("Apply to all apps", isOn: $applyAllAppsEnabled.animation())
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
                                switch option {
                                case "Watch":
                                    SettingsLabel(icon: "apple \(option.lowercased())", id: option)
                                        .foregroundStyle(Color["Label"])
                                default:
                                    SettingsLabel(icon: "apple\(option.lowercased())", id: option)
                                        .foregroundStyle(Color["Label"])
                                }
                                Spacer()
                                Image(systemName: "\(selected.contains(option) ? "checkmark" : "")")
                            }
                        }
                    }
                } header: {
                    Text("Apply To")
                }
            }
        }
        .toolbar {
            Button("Play", action: speakText)
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
