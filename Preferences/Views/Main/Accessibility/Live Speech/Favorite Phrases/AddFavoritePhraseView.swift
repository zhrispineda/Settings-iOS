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
    
    var body: some View {
        CustomList(title: "Add Favorite Phrase") {
            Section {
                HStack {
                    Text("Phrase\t\t")
                    TextField("", text: $phraseText)
                }
            } footer: {
                Text("Create phrases that you can quickly speak with Live Speech.")
            }
        }
        .toolbar {
            Button {
                dismiss()
            } label: {
                Text("Save")
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
