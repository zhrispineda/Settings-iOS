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
    
    var body: some View {
        CustomList(title: "Slow Keys") {
            Section(content: {
                Toggle("Slow Keys", isOn: $slowKeysEnabled.animation())
            }, footer: {
                Text("Slow Keys adjusts the amount of time between when a key is pressed and when it is activated.")
            })
            
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
    SlowKeysView()
}
