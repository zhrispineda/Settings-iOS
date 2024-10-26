//
//  SiriLanguageView.swift
//  Preferences
//
//  Settings > Siri > Language
//

import SwiftUI

let languages = ["Arabic", "Chinese (Cantonese - China)", "Chinese (Cantonese - Hong Kong (China))", "Chinese (Mandarin - China)", "Chinese (Mandarin - Taiwan (China))", "Danish", "Dutch (Belgium)", "Dutch (Netherlands)", "English (Australia)", "English (Canada)", "English (India)", "English (Ireland)", "English (New Zealand)", "English (Singapore)", "English (South Africa)", "English (United Kingdom)", "English (United States)", "Finnish", "French (Belgium)", "French (Canada)", "French (France)", "French (Switzerland)", "German (Austria)", "German (Germany)", "German (Switzerland)", "Hebrew", "Italian (Italy)", "Italian (Switzerland)", "Japanese", "Korean", "Malay", "Norwegian Bokmål", "Portuguese (Brazil)", "Russian", "Spanish (Chile)", "Spanish (Mexico)", "Spanish (Spain)", "Spanish (United States)", "Swedish", "Thai", "Turkish"]

struct SiriLanguageView: View {
    // Variables
    @State private var selected = "English (United States)"
    
    var body: some View {
        CustomList(title: "LANGUAGE".localize(table: "AssistantSettings")) {
            ForEach(languages, id: \.self) { lang in
                if lang == "English (India)" {
                    NavigationLink(destination: EnglishIndiaView()) {
                        Label(lang, systemImage: selected == lang ? "checkmark" : "")
                            .tint(Color["Label"])
                    }
                } else {
                    Button {
                        selected = lang
                    } label: {
                        Label(lang, systemImage: selected == lang ? "checkmark" : "")
                            .tint(Color["Label"])
                            .lineLimit(1)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriLanguageView()
    }
}
