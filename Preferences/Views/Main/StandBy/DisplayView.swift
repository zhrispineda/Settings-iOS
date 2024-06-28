//
//  DisplayView.swift
//  Preferences
//
//  Settings > StandBy > Display
//

import SwiftUI

struct DisplayView: View {
    // Variables
    @State private var selected = "Automatically"
    let options = ["Automatically", "After 20 Seconds", "Never"]
    
    @State private var nightModeEnabled = true
    @State private var motionWakeEnabled = true
    
    var body: some View {
        CustomList(title: "Display") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("\nTurn Display Off")
            } footer: {
                Text("When set to Automatically, the display will intelligently turn off when iPhone is not in use and the room is dark.")
            }
            
            Section {
                Toggle("Night Mode", isOn: $nightModeEnabled)
                    .disabled(selected == "Never")
            } header: {
                Text("At Night")
            } footer: {
                Text("StandBy with a red tint in lower ambient lighting.")
            }
            
            if selected == "Automatically" {
                Section {
                    Toggle("Motion To Wake", isOn: $motionWakeEnabled)
                } footer: {
                    Text("StandBy will turn on the display when motion is detected at night.")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DisplayView()
    }
}
