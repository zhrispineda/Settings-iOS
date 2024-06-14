//
//  LocationPermissionsDetailView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Location Services > [Selection]
//

import SwiftUI

struct LocationPermissionsDetailView: View {
    // Variables
    var title = String()
    @State var selected = "Ask Next Time Or When I Share"
    let options = ["Never", "Ask Next Time Or When I Share", "Always"]
    @State private var preciseLocationEnabled = true
    
    var body: some View {
        CustomList(title: title) {
            Section {
                ForEach(options, id: \.self) { option in
                    Button {
                        withAnimation {
                            selected = option
                        }
                    } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if selected == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } header: {
                Text("\n\nAllow Location Access")
            } footer: {
                if title == "Siri & Dictation" {
                    Text("App explanation: \u{201C}Siri uses your location for things like answering questions and offering suggestions about what‘s nearby.\u{201D}")
                }
            }
            
            if selected != "Never" {
                Section {
                    Toggle("Precise Location", isOn: $preciseLocationEnabled)
                } footer: {
                    Text("Allows apps to use your specific location. With this setting off, apps can only determine your approximate location.")
                }
            }
        }
    }
}

#Preview {
    LocationPermissionsDetailView()
}
