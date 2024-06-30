//
//  SafariMicrophoneView.swift
//  Preferences
//
//  Settings > Safari > Microphone
//

import SwiftUI

struct SafariMicrophoneView: View {
    // Variables
    @State private var selected = "Ask"
    let options = ["Ask", "Deny", "Allow"]
    
    var body: some View {
        CustomList(title: "Microphone") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Microphone Access On All Websites")
            }
        }
        .toolbar {
            EditButton()
                .disabled(true)
        }
    }
}

#Preview {
    NavigationStack {
        SafariMicrophoneView()
    }
}
