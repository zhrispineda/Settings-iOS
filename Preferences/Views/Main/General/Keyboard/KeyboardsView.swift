//
//  KeyboardsView.swift
//  Preferences
//
//  Settings > General > Keyboard > Keyboards
//

import SwiftUI

struct KeyboardsView: View {
    // Variables
    @State private var keyboards = ["English (US)", "Emoji"]
    
    var body: some View {
        CustomList(title: "Keyboards") {
            Section {
                ForEach(keyboards, id: \.self) { keyboard in
                    if keyboard != "Emoji" {
                        NavigationLink(keyboard, destination: SelectOptionList(title: "English (US)", options: ["QWERTY", "AZERTY", "QWERTZ", "Dvorak"], selected: "QWERTY"))
                    } else {
                        Text(keyboard)
                    }
                }
                .onMove { prev, new in
                    keyboards.move(fromOffsets: prev, toOffset: new)
                }
            }
            
            Section {
                Button("Add New Keyboard") {}
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
    }
}

#Preview {
    NavigationStack {
        KeyboardsView()
    }
}
