//
//  AddFavoritePhraseView.swift
//  Preferences
//
//  Settings > Accessibility > Live Speech > Favorite Phrases > +
//

import SwiftUI

struct AddFavoritePhraseView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var phraseText = ""
    let path = "/System/Library/PreferenceBundles/AccessibilitySettings.bundle"
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "LIVE_SPEECH_ADD_FAVORITE_PHRASE".localized(path: path, table: table)) {
            Section {
                HStack {
                    Text("LIVE_SPEECH_PHRASE".localized(path: path, table: table) + "\t\t")
                    TextField("", text: $phraseText)
                }
            } footer: {
                Text("LIVE_SPEECH_PHRASES_FOOTER".localized(path: path, table: table))
            }
        }
        .toolbar {
            Button {
                dismiss()
            } label: {
                Text("SAVE".localized(path: path, table: table))
                    .disabled(phraseText.isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddFavoritePhraseView()
    }
}
