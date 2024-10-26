//
//  SiriResponsesView.swift
//  Preferences
//
//  Settings > Siri > Siri Responses
//

import SwiftUI

struct SiriResponsesView: View {
    // Variables
    @State private var selected = "AUTOMATIC"
    @State private var alwaysShowSiriCaptionsEnabled = false
    @State private var alwaysShowRequestEnabled = false
    let options = ["VOICE_FEEDBACK_TITLE_NEVER", "AUTOMATIC", "VOICE_FEEDBACK_TITLE_PREFER_SPOKEN"]
    let table = "AssistantSettings"
    let accTable = "Accessibility"
    let audTable = "AssistantAudioFeedback"
    
    var body: some View {
        CustomList(title: "VOICE_FEEDBACK".localize(table: table), topPadding: true) {
            Section {
                Picker("SIRI_SETTINGS_TYPE_TO_SIRI_TTS".localize(table: accTable), selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0.localize(table: accTable))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("SIRI_SETTINGS_TYPE_TO_SIRI_TTS", tableName: accTable)
            } footer: {
                switch selected {
                case "VOICE_FEEDBACK_TITLE_NEVER":
                    if UIDevice.iPhone {
                        Text("VOICE_FEEDBACK_FOOTER_NEVER_IPHONE", tableName: accTable)
                    } else if UIDevice.iPad {
                        Text("VOICE_FEEDBACK_FOOTER_NEVER_IPAD", tableName: accTable)
                    }
                case "AUTOMATIC":
                    Text("VOICE_FEEDBACK_FOOTER_TEXT_AUTOMATIC", tableName: accTable)
                case "VOICE_FEEDBACK_TITLE_PREFER_SPOKEN":
                    Text("VOICE_FEEDBACK_FOOTER_PREFER_SPOKEN", tableName: accTable)
                default:
                    Text(String())
                }
            }
            
            Section {
                Toggle("ALWAYS_PRINT_RESPONSE".localize(table: audTable), isOn: $alwaysShowSiriCaptionsEnabled)
            } footer: {
                Text("ALWAYS_PRINT_RESPONSE_FOOTER_TEXT", tableName: audTable)
            }
            
            Section {
                Toggle("ALWAYS_SHOW_RECOGNIZED_SPEECH".localize(table: audTable), isOn: $alwaysShowRequestEnabled)
            } footer: {
                Text("ALWAYS_SHOW_RECOGNIZED_SPEECH_FOOTER_TEXT", tableName: audTable)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SiriResponsesView()
    }
}
