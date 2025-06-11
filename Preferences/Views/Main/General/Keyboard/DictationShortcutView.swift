//
//  DictationShortcutView.swift
//  Preferences
//
//  Settings > General > Keyboard > Dictation Shortcut
//

import SwiftUI

struct DictationShortcutView: View {
    @State private var selectedOption = "Control"
    let options = ["Control", "Command", "None"]
    
    var body: some View {
        CustomList(title: "Dictation Shortcut", topPadding: true) {
            Picker("Press Twice to Start Dictation:", selection: $selectedOption) {
                ForEach(options, id: \.self) { shortcut in
                    if shortcut != "None" {
                        Text("\(Image(systemName: shortcut.lowercased()))\t\(shortcut)")
                    } else {
                        Text(shortcut)
                    }
                }
            }
            .pickerStyle(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        DictationShortcutView()
    }
}
