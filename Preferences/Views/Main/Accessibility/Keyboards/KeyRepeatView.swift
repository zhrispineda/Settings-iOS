//
//  KeyRepeatView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards > Key Repeat
//

import SwiftUI

struct KeyRepeatView: View {
    // Variables
    @State private var keyRepeatEnabled = true
    @State private var keyRepeatInterval = 0.10
    @State private var delayUntilRepeat = 0.40
    let table = "KeyboardsSettings"
    
    var body: some View {
        CustomList(title: "KEY_REPEAT".localize(table: table)) {
            Section {
                Toggle("KEY_REPEAT".localize(table: table), isOn: $keyRepeatEnabled.animation())
            } footer: {
                Text("KEY_REPEAT_FOOTER", tableName: table)
            }
            
            if keyRepeatEnabled {
                Section {
                    Stepper(
                        value: $keyRepeatInterval,
                        in: 0.03...2.00,
                        step: 0.01
                    ) {
                        HStack {
                            Text("\(keyRepeatInterval, specifier: "%.2f")")
                                .frame(width: 50, alignment: .leading)
                            Text(keyRepeatInterval == 1.00 ? "Second" : "Seconds")
                                .foregroundStyle(.secondary)
                        }
                    }
                } header: {
                    Text("KEY_REPEAT_INTERVAL", tableName: table)
                }
                
                Section {
                    Stepper(
                        value: $delayUntilRepeat,
                        in: 0.20...2.00,
                        step: 0.01
                    ) {
                        HStack {
                            Text("\(delayUntilRepeat, specifier: "%.2f")")
                                .frame(width: 50, alignment: .leading)
                            Text(delayUntilRepeat == 1.00 ? "Second" : "Seconds")
                                .foregroundStyle(.secondary)
                        }
                    }
                } header: {
                    Text("KEY_REPEAT_DELAY", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        KeyRepeatView()
    }
}
