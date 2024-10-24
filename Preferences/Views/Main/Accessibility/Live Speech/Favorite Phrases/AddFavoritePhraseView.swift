//
//  AddFavoritePhraseView.swift
//  Preferences
//
//  Settings > Accessibility > Live Speech > Favorite Phrases > +
//

import SwiftUI

struct AddFavoritePhraseView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var phraseText = String()
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "LIVE_SPEECH_ADD_FAVORITE_PHRASE".localize(table: table)) {
            Section {
                HStack {
                    Text("LIVE_SPEECH_PHRASE".localize(table: table) + "\t\t")
                    TextField("", text: $phraseText)
                }
            } footer: {
                Text("LIVE_SPEECH_PHRASES_FOOTER", tableName: table)
            }
        }
        .toolbar {
            Button {
                dismiss()
            } label: {
                Text("SAVE", tableName: table)
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
