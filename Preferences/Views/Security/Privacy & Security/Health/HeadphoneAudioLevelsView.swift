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
    let path = "/System/Library/PreferenceBundles/Privacy/HealthPrivacySettings.bundle"
    
    var body: some View {
        CustomList(title: "HEADPHONE_AUDIO_LEVELS".localized(path: path), topPadding: true) {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localized(path: path))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("SAVE_IN_HEALTH".localized(path: path))
            } footer: {
                if selected == "FOR_EIGHT_DAYS" {
                    Text("SAVE_IN_HEALTH_FOR_8_DAYS_FOOTER_TEXT".localized(path: path))
                } else if selected == "UNTIL_I_DELETE" {
                    Text("SAVE_IN_HEALTH_FOOTER_TEXT".localized(path: path))
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
