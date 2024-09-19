//
//  AddLanguageView.swift
//  Preferences
//
//  Settings > General > Keyboards > Keyboards > [Language] > Add Language...
//

import SwiftUI

struct AddLanguageView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    let languages = ["Bangla", "Czech", "Danish", "Dutch (Belgium)", "Dutch (Netherlands)", "English (Australia)", "English (Canada)", "English (India)", "English (Japan)", "English (New Zealand)", "English (Singapore)", "English (South Africa)", "English (UK)", "French (Belgium)", "French (Canada)", "French (France)", "French (Switzerland)", "German (Austria)", "German (Germany)", "German (Switzerland)", "Gujarati", "Hindi", "Icelandic", "Indonesian", "Italian", "Lithuanian", "Marathi", "Norwegian Bokmål", "Norwegian Nynorsk", "Polish", "Portuguese (Brazil)", "Portuguese (Portugal)", "Punjabi", "Romanian", "Slovenian", "Spanish (Latin America)", "Spanish (Mexico)", "Spanish (Spain)", "Swedish", "Tamil", "Telugu", "Turkish", "Vietnamese"]
    
    var body: some View {
        CustomList(title: "Add Language") {
            ForEach(languages, id: \.self) { lang in
                Button(lang) {
                    dismiss()
                }
                .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddLanguageView()
    }
}
