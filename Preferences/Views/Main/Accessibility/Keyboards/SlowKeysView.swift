//
//  SlowKeysView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards > Slow Keys
//

import SwiftUI

struct SlowKeysView: View {
    // Variables
    @State private var slowKeysEnabled = false
    @State private var time = 0.30
    let table = "KeyboardsSettings"
    
    var body: some View {
        CustomList(title: "SLOW_KEYS".localize(table: table)) {
            Section {
                Toggle("SLOW_KEYS".localize(table: table), isOn: $slowKeysEnabled.animation())
            } footer: {
                Text("SLOW_KEYS_FOOTER", tableName: table)
            }
            
            if slowKeysEnabled {
                Section {
                    Stepper(
                        value: $time,
                        in: 0.10...5.00,
                        step: 0.05
                    ) {
                        HStack {
                            Text("\(time, specifier: "%.2f")")
                                .frame(width: 50, alignment: .leading)
                            Text(time == 1.00 ? "Second" : "Seconds")
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
        SlowKeysView()
    }
}
