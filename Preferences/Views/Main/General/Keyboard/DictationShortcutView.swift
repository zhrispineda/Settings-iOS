//
//  DictationShortcutView.swift
//  Preferences
//
//  Settings > General > Keyboard > Dictation Shortcut
//

import SwiftUI

struct DictationShortcutView: View {
    // Variables
    @State private var selectedOption = "Control"
    let options = ["Control", "Command", "None"]
    
    var body: some View {
        CustomList(title: "Dictation Shortcut") {
            Picker("Press Twice to Start Dictation:", selection: $selectedOption) {
                ForEach(options, id: \.self) {
                    if $0 != "None" {
                        Text(Image(systemName: "\($0.lowercased())")) + Text($0)
                    } else {
                        Text($0)
                    }
                }
            }
            .pickerStyle(.inline)
        }
    }
}

#Preview {
    DictationShortcutView()
}
