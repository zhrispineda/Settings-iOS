//
//  OneHandedKeyboardView.swift
//  Preferences
//
//  Settings > General > Keyboard > One-Handed Keyboard
//

import SwiftUI

struct OneHandedKeyboardView: View {
    // Variables
    @State private var selected = "Off"
    let options = ["Off", "Left", "Right"]
    
    var body: some View {
        CustomList(title: "One-Handed Keyboard") {
            Section {
                ForEach(options, id: \.self) { option in
                    Button {
                        selected = option
                    } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if selected == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } footer: {
                Text("You can quickly access these settings by pressing and holding the Emoji or Globe key on the keyboard.")
            }
        }
    }
}

#Preview {
    OneHandedKeyboardView()
}
