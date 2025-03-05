//
//  HardwareKeyboardView.swift
//  Preferences
//
//  Settings > General > Keyboard > Hardware Keyboard
//

import SwiftUI

struct HardwareKeyboardView: View {
    // Variables
    @State private var autoCapitalizationEnabled = true
    @State private var autoCorrectionEnabled = true
    @State private var periodShortcutEnabled = true
    
    var body: some View {
        CustomList(title: "Hardware Keyboard") {
            Section {
                CustomNavigationLink("English (US)", status: "Automatic — U.S.", destination: HardwareKeyboardLanguageView())
            }
            
            Section {
                Toggle("Auto-Capitalization", isOn: $autoCapitalizationEnabled)
                Toggle("Auto-Correction", isOn: $autoCorrectionEnabled)
                Toggle("\u{201C}.\u{201D} Shortcut", isOn: $periodShortcutEnabled)
            } footer: {
                Text("Pressing the space bar twice will insert a period followed by a space.")
            }
            
            Section {
                NavigationLink("Modifier Keys", destination: ModifierKeysView())
            }
            
            Section {
                CustomNavigationLink("Keyboard Type", status: "ANSI", destination: SelectOptionList(title: "Keyboard Type", options: ["ANSI (U.S.)", "ISO (International)", "JIS (Japan)"], selected: "ANSI (U.S.)"))
            } footer: {
                Text("Choose the correct type for your keyboard to ensure that all keys function correctly.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        HardwareKeyboardView()
    }
}
