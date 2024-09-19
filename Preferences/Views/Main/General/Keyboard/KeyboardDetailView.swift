//
//  KeyboardDetailView.swift
//  Preferences
//
//  Settings > Keyboard > Keyboards > [Language]
//

import SwiftUI

struct KeyboardDetailView: View {
    // Variables
    @State private var selected = "QWERTY"
    let options = ["QWERTY", "AZERTY", "QWERTZ", "Dvorak"]
    
    var body: some View {
        CustomList(title: "English (US)", topPadding: true) {
            Section {
                Text("English (US)")
                NavigationLink("Add Language...") {
                    AddLanguageView()
                }
            } header: {
                Text("Languages")
            } footer: {
                Text("Type in more than one language on the same keyboard with a multilingual keyboard.")
            }
            
            Section("Keyboard Layout") {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
        }
    }
}

#Preview {
    NavigationStack {
        KeyboardDetailView()
    }
}
