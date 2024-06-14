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
    
    var body: some View {
        CustomList(title: "Auto-Hide") {
            Section {
                Toggle("Auto-Hide", isOn: $autoHideEnabled.animation())
            } footer: {
                Text("The time it takes for focus to disappear due to inactivity.")
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
