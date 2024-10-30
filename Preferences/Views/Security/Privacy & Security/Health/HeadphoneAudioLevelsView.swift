//
//  HeadphoneAudioLevelsView.swift
//  NanoSettings
//
//  Settings > Privacy & Security > Health > Headphone Audio Levels
//

import SwiftUI

struct HeadphoneAudioLevelsView: View {
    @State private var selected = "UNTIL_I_DELETE"
    let options = ["FOR_EIGHT_DAYS", "UNTIL_I_DELETE"]
    let table = "HealthPrivacySettings"
    
    var body: some View {
        CustomList(title: "HEADPHONE_AUDIO_LEVELS".localize(table: table), topPadding: true) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("SAVE_IN_HEALTH", tableName: table)
            } footer: {
                if selected == "FOR_EIGHT_DAYS" {
                    Text("SAVE_IN_HEALTH_FOR_8_DAYS_FOOTER_TEXT", tableName: table)
                } else if selected == "UNTIL_I_DELETE" {
                    Text("SAVE_IN_HEALTH_FOOTER_TEXT", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HeadphoneAudioLevelsView()
    }
}
