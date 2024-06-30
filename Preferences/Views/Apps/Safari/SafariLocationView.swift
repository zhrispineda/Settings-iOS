//
//  SafariLocationView.swift
//  Preferences
//
//  Settings > Safari > Location
//

import SwiftUI

struct SafariLocationView: View {
    // Variables
    @State private var selected = "Ask"
    let options = ["Ask", "Deny", "Allow"]
    
    var body: some View {
        CustomList(title: "Location") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Location Access On All Websites")
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
        SafariLocationView()
    }
}
