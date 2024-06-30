//
//  AirPlaySuggestionsView.swift
//  Preferences
//
//  Settings > Developer > AirPlay Suggestions
//

import SwiftUI

struct AirPlaySuggestionsView: View {
    // Variables
    @State private var selected = "Default"
    let options = ["Default", "Always Prompt User with Suggested TV", "Always Use Suggested TV"]
    
    var body: some View {
        CustomList(title: "AirPlay Suggestions") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Suggestion Test Mode")
            } footer: {
                Text("When using a mode other than “Default“, select an AirPlay-capable TV as the suggested TV to use for testing. This TV must be connected to the same Wi-Fi network as this \(Device().model).")
            }
            
            if selected != "Default" {
                Section {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } header: {
                    Text("Choose a Suggested TV")
                }
            }
        }
    }
}

#Preview {
    AirPlaySuggestionsView()
}
