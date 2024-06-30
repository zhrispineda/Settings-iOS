//
//  HardwareKeyboardLanguageView.swift
//  Preferences
//
//  Settings > General > Keyboard > Hardware Keyboard > [Language]
//

import SwiftUI

struct HardwareKeyboardLanguageView: View {
    // Variables
    @State private var selected = "Automatic – U.S."
    
    let options = ["Automatic – U.S.", "U.S.", "ABC", "ABC – AZERTY", "ABC – QWERTZ", "ABC – Extended", "ABC – India", "Albanian", "Australian", "Austrian", "Azeri", "Belgian", "Brazilian", "Brazilian – ABNT2", "Brazilian – Legacy", "British", "British – PC", "Canadian", "Canadian – CSA", "Canadian – PC", "Colemak", "Croatian", "Croatian – PC", "Czech", "Czech – QWERTY", "Danish", "Dutch", "Dvorak", "Dvorak – QWERTY ⌘", "Dvorak – Left-Handed", "Dvorak – Right-Handed", "Estonian", "Faroese", "Finnish", "Finnish – Extended", "Finnish Sami – PC", "French", "French – Numerical", "French – PC", "German", "German – Standard", "Hungarian", "Hungarian – QWERTY", "Icelandic", "Italian", "Italian – QZERTY", "Irish", "Irish – Extended", "Latin American", "Latvian", "Lithuanian", "Maltese", "Northern Sami", "Norwegian", "Norwegian – Extended", "Norwegian Sami – PC", "Portuguese", "Polish", "Polish – QWERTZ", "Romanian", "Romanian – Standard", "Sami – PC", "Slovak", "Slovak – QWERTY", "Slovenian", "Spanish", "Spanish – Legacy", "Swedish", "Swedish – Legacy", "Swedish Sami – PC", "Swiss French", "Swiss German", "Turkish Q", "Turkish F", "Turkish Q – Legacy", "Turkish F – Legacy", "Turkmen", "U.S. International – PC"]
    
    var body: some View {
        CustomList(title: "English (US)") {
            Picker("", selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
        }
    }
}

#Preview {
    HardwareKeyboardLanguageView()
}
