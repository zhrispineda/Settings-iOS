//
//  SpeakSelectionVoicesView.swift
//  Preferences
//
//  Settings > Accessibility > Spoken Content > Voices
//

import SwiftUI

struct SpeakSelectionVoicesView: View {
    // Variables
    let languages = ["English", "Arabic", "Bangla", "Basque", "Bhojpuri", "Bulgarian", "Catalan", "Chinese", "Croatian", "Czech", "Danish", "Dutch", "Finnish", "French", "Galician", "German", "Greek", "Hebrew", "Hindi", "Hungarian", "Indonesian", "Italian", "Japanese", "Kannada", "Korean", "Malay", "Marathi", "Norwegian Bokmål", "Persian", "Polish", "Portuguese", "Romanian", "Russian", "Shanghainese", "Slovak", "Slovenian", "Spanish", "Swedish", "Tamil", "Telugu", "Thai", "Turkish", "Ukrainian", "Vietnamese"]
    let voices = ["Samantha", "Majed", "", "", "", "Daria", "Montse", "Tingting", "Lana", "Zuzuna", "Sara", "Xander", "Satu", "Thomas", "", "Anna", "Melina", "Carmit", "Lekha", "Tünde", "Damayanti", "Alice", "Kyoko", "", "Yuna", "Amira", "", "Nora", "", "Zosia", "Luciana", "Ioana", "Milena", "", "Laura", "", "Paulina", "Alva", "", "", "Kanya", "Yelda", "Lesya", "Lihn"]
    let table = "VoiceOverSettings"
    
    var body: some View {
        CustomList(title: "SPEECH_VOICES".localize(table: table)) {
            ForEach(Array(languages.enumerated()), id: \.offset) { index, language in
                CustomNavigationLink(language, status: voices[index], destination: SpeakSelectionVoiceDetailView(title: language))
            }
        }
    }
}

#Preview {
    NavigationStack {
        SpeakSelectionVoicesView()
    }
}
