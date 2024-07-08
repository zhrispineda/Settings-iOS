//
//  ModifierKeysView.swift
//  Preferences
//
//  Settings > General > Keyboard > Hardware Keyboard > Modifier Keys
//

import SwiftUI

struct ModifierKeysView: View {
    var body: some View {
        CustomList(title: "Modifier Keys") {
            Section {} footer: {
                Text("For each modifier key, choose the action you want it to perform.")
            }
            
            Section {
                Button("Restore Defaults") {}
            }
        }
    }
}

#Preview {
    ModifierKeysView()
}
