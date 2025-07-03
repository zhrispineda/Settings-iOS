//
//  DisplayView.swift
//  Preferences
//
//  Settings > StandBy > Display
//

import SwiftUI

struct DisplayView: View {
    @AppStorage("AmbientSelectedSetting") private var selected = "ALWAYS_ON_DISPLAY_TURN_OFF_AUTOMATICALLY"
    @AppStorage("AmbientEnabledSetting") private var nightModeEnabled = true
    @AppStorage("AmbientMotionSetting") private var motionWakeEnabled = true
    let options = ["ALWAYS_ON_DISPLAY_TURN_OFF_AUTOMATICALLY", "ALWAYS_ON_DISPLAY_TURN_OFF_AFTER_IDLE", "ALWAYS_ON_DISPLAY_TURN_OFF_NEVER"]
    let path = "/System/Library/PreferenceBundles/AmbientSettings.bundle"
    let table = "AmbientSettings"
    
    var body: some View {
        CustomList(title: "ALWAYS_ON_DISPLAY_OPTIONS".localized(path: path, table: table), topPadding: true) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path, table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("TURN_DISPLAY_OFF_GROUP_HEADER".localized(path: path, table: table))
            } footer: {
                Text("ALWAYS_ON_DISPLAY_TURN_OFF_FOOTER_AUTOMATICALLY".localized(path: path, table: table))
            }
            
            Section {
                Toggle("NIGHT_MODE_ENABLED".localized(path: path, table: table), isOn: $nightModeEnabled)
                    .disabled(selected == "ALWAYS_ON_DISPLAY_TURN_OFF_NEVER")
            } header: {
                Text("AT_NIGHT_GROUP_HEADER".localized(path: path, table: table))
            } footer: {
                Text("NIGHT_MODE_ENABLED_FOOTER".localized(path: path, table: table, "AMBIENT_FEATURE_NAME".localized(path: path, table: table)))
            }
            
            if selected == "ALWAYS_ON_DISPLAY_TURN_OFF_AUTOMATICALLY" {
                Section {
                    Toggle("MOTION_TO_WAKE_ENABLED".localized(path: path, table: table), isOn: $motionWakeEnabled)
                } footer: {
                    Text("MOTION_TO_WAKE_ENABLED_FOOTER".localized(path: path, table: table, "AMBIENT_FEATURE_NAME".localized(path: path, table: table)))
                }
            }
        }
        .animation(.default, value: selected)
    }
}

#Preview {
    NavigationStack {
        DisplayView()
    }
}
