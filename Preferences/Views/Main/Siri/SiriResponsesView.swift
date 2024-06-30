//
//  SiriResponsesView.swift
//  Preferences
//
//  Settings > Siri > Siri Responses
//

import SwiftUI

struct SiriResponsesView: View {
    // Variables
    @State private var selected = "Automatic"
    @State private var alwaysShowSiriCaptionsEnabled = false
    @State private var alwaysShowSpeechEnabled = false
    let options = ["Prefer Silent Responses", "Automatic", "Prefer Spoken Responses"]
    
    var body: some View {
        CustomList(title: "Siri Responses") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Spoken Responses")
            }
            
            Section {
                Toggle("Always Show Siri Captions", isOn: $alwaysShowSiriCaptionsEnabled)
            } footer: {
                Text("Show what Siri says on screen.")
            }
            
            Section {
                Toggle("Always Show Speech", isOn: $alwaysShowSpeechEnabled)
            } footer: {
                Text("Show a transcription of your speech on screen.")
            }
        }
    }
}

#Preview {
    SiriResponsesView()
}
