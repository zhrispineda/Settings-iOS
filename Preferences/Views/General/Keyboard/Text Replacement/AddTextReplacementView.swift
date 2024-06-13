//
//  AddTextReplacementView.swift
//  Preferences
//
//  Settings > General > Keyboard > Text Replacement > +
//

import SwiftUI

struct AddTextReplacementView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @State private var phraseText = String()
    @State private var shortcutText = String()
    
    var body: some View {
        CustomList(title: "Text Replacement") {
            Section {
                HStack {
                    Text("Phrase")
                    TextField("", text: $phraseText)
                        .padding(.horizontal, 5)
                }
                HStack {
                    Text("Shortcut")
                    TextField("Optional", text: $shortcutText)
                        .padding(.horizontal, 5)
                }
            } footer: {
                Text("Create a shortcut that will automatically expand into the word or phrase as you type.")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    dismiss()
                }
                .disabled(phraseText.isEmpty)
            }
        }
    }
}

#Preview {
    AddTextReplacementView()
}
