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
            Section(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selected = option
                    }, label: {
                        HStack {
                            Text(option)
                                .lineLimit(1)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            Image(systemName: "\(selected == option ? "checkmark" : "")")
                                .bold()
                        }
                    })
                }
            }, header: {
                Text("\n\nSuggestion Test Mode")
            }, footer: {
                Text("When using a mode other than “Default“, select an AirPlay-capable TV as the suggested TV to use for testing. This TV must be connected to the same Wi-Fi network as this \(Device().model).")
            })
            
            if selected != "Default" {
                Section(content: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                }, header: {
                    Text("Choose a Suggested TV")
                })
            }
        }
    }
}

#Preview {
    AirPlaySuggestionsView()
}
