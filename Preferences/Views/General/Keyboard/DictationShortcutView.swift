//
//  DictationShortcutView.swift
//  Preferences
//
//  Settings > General > Keyboard > Dictation Shortcut
//

import SwiftUI

struct DictationShortcutView: View {
    // Variables
    @State private var selectedOption: String? = "Control"
    let options = ["Control", "Command", "None"]
    
    var body: some View {
        CustomList(title: "Dictation Shortcut") {
            Section {
                ForEach(options, id: \.self) { option in
                    Button {
                        selectedOption = option
                    } label: {
                        HStack {
                            if option == "None" {
                                Text(option)
                            } else {
                                Text(Image(systemName: "\(option.lowercased())")) + Text("\t" + option)
                            }
                            Spacer()
                            if selectedOption == option {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
                            }
                        }
                        .foregroundStyle(Color["Label"])
                    }
                }
            } header: {
                Text("\n\nPress twice to start dictation:")
            }
        }
    }
}

#Preview {
    DictationShortcutView()
}
