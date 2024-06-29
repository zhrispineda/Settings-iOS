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
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("You can quickly access these settings by pressing and holding the Emoji or Globe key on the keyboard.")
            }
        }
    }
}

#Preview {
    OneHandedKeyboardView()
}
