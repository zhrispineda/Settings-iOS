//
//  DisplayView.swift
//  Preferences
//
//  Settings > StandBy > Display
//

import SwiftUI

struct DisplayView: View {
    // Variables
    @AppStorage("AmbientSelectedSetting") private var selected = "ALWAYS_ON_DISPLAY_TURN_OFF_AUTOMATICALLY"
    @AppStorage("AmbientEnabledSetting") private var nightModeEnabled = true
    @AppStorage("AmbientMotionSetting") private var motionWakeEnabled = true
    let options = ["ALWAYS_ON_DISPLAY_TURN_OFF_AUTOMATICALLY", "ALWAYS_ON_DISPLAY_TURN_OFF_AFTER_IDLE", "ALWAYS_ON_DISPLAY_TURN_OFF_NEVER"]
    let table = "AmbientSettings"
    
    var body: some View {
        CustomList(title: "ALWAYS_ON_DISPLAY_OPTIONS".localize(table: table), topPadding: true) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("TURN_DISPLAY_OFF_GROUP_HEADER".localize(table: table))
            } footer: {
                Text("ALWAYS_ON_DISPLAY_TURN_OFF_FOOTER_AUTOMATICALLY".localize(table: table))
            }
            
            Section {
                Toggle("NIGHT_MODE_ENABLED".localize(table: table), isOn: $nightModeEnabled)
                    .disabled(selected == "ALWAYS_ON_DISPLAY_TURN_OFF_NEVER")
            } header: {
                Text("AT_NIGHT_GROUP_HEADER".localize(table: table))
            } footer: {
                Text("NIGHT_MODE_ENABLED_FOOTER".localize(table: table, "AMBIENT_FEATURE_NAME"))
            }
            
            if selected == "ALWAYS_ON_DISPLAY_TURN_OFF_AUTOMATICALLY" {
                Section {
                    Toggle("MOTION_TO_WAKE_ENABLED".localize(table: table), isOn: $motionWakeEnabled)
                } footer: {
                    Text("MOTION_TO_WAKE_ENABLED_FOOTER".localize(table: table, "AMBIENT_FEATURE_NAME"))
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
