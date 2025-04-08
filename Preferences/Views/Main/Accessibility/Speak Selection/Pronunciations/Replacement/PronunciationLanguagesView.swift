//
//  PronunciationLanguagesView.swift
//  Preferences
//
//  Settings > Accessibility > Spoken Content > Pronunciations > Replacement > Languages
//

import SwiftUI

struct PronunciationLanguagesView: View {
    // Variables
    @State private var selected = ["ALL_LANGUAGES"]
    let languages = ["Arabic (World)", "Bangla (India)", "Basque (Spain)", "Bhojpuri (India)", "Bulgarian (Bulgaria)", "Catalan (Spain)", "Chinese (China)", "Chinese (Hong Kong [China])", "Chinese (Liaoning, China mainland)", "Chinese (Shaanxi, China mainland)", "Chinese (Sichuan, China mainland)", "Chinese (Taiwan [China])", "Croatian (Croatia)", "Czech (Czechia)", "Danish (Denmark)", "Dutch (Belgium)", "Dutch (Netherlands)", "English (South Africa)", "English (India)", "English (Scotland, UK)", "English (UK)", "English (Australia)", "English (US)", "English (Ireland)", "Finnish (Finland)", "French (Belgium)", "French (Canada)", "French (France)", "Galician (Spain)", "German (Germany)", "Greek (Greece)", "Hebrew (Israel)", "Hindi (Indian)", "Hungarian (Hungary)", "Indonesian (Indonesia)", "Italian (Italy)", "Japanese (Japan)", "Kannada (India)", "Korean (South Korea)", "Malay (Malaysia)", "Marathi (India)", "Norwegian Bokmål (Norway)", "Persian (Iran)", "Polish (Poland)", "Portugese (Brazil)", "Portugese (Portugal)", "Romanian (Romania)", "Russian (Russia)", "Shanghainese (China mainland)", "Slovak (Slovakia)", "Slovenian (Slovenia)", "Spanish (Argentina)", "Spanish (Chile)", "Spanish (Columbia)", "Spanish (Mexico)", "Spanish (Spain)", "Swedish (Sweden)", "Tamil (India)", "Telugu (India)", "Thai (Thailand)", "Turkish (Türkiye)", "Ukrainian (Ukraine)", "Valencian (Spain)", "Vietnamese (Vietnam)"]
    let table = "VoiceOverSettings"
    
    var body: some View {
        CustomList(title: "PRONUNCIATION_LANGUAGE".localize(table: table)) {
            Section {
                Button {
                    selected = ["ALL_LANGUAGES"]
                } label: {
                    HStack {
                        Text("ALL_LANGUAGES", tableName: table)
                        Spacer()
                        if selected.contains("ALL_LANGUAGES") {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .foregroundStyle(.primary)
            } footer: {
                Text("PRONUNCIATION_LANGUAGE_HELP", tableName: table)
            }
            
            Section {
                ForEach(languages, id: \.self) { option in
                    Button {
                        if selected.contains("ALL_LANGUAGES") {
                            selected = []
                        }
                        if let index = selected.firstIndex(of: option) {
                            selected.remove(at: index)
                            if selected.isEmpty {
                                selected = ["ALL_LANGUAGES"]
                            }
                        } else {
                            selected.append(option)
                        }
                    } label: {
                        HStack {
                            Text(option)
                            Spacer()
                            if selected.contains(option) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PronunciationLanguagesView()
    }
}
