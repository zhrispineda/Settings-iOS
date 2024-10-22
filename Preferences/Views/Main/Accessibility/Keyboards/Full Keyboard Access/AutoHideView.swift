//
//  AutoHideView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards > Full Keyboard Access > Auto-Hide
//

import SwiftUI

struct AutoHideView: View {
    // Variables
    @State private var autoHideEnabled = true
    @State private var time = 15
    let table = "FullKeyboardAccessSettings"
    
    var body: some View {
        CustomList(title: "FOCUS_RING_TIMEOUT".localize(table: table)) {
            Section {
                Toggle("FOCUS_RING_TIMEOUT".localize(table: table), isOn: $autoHideEnabled.animation())
            } footer: {
                Text("FOCUS_RING_TIMEOUT_FOOTER", tableName: table)
            }
            
            if autoHideEnabled {
                Section {
                    Stepper(
                        value: $time,
                        in: 1...60,
                        step: 1
                    ) {
                        HStack {
                            Text("\(time)")
                                .frame(width: 25, alignment: .leading)
                            Text(time == 1 ? "Second" : "Seconds")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AutoHideView()
    }
}
