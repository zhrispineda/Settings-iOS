//
//  SafariMicrophoneView.swift
//  Preferences
//
//  Settings > Safari > Microphone
//

import SwiftUI

struct SafariMicrophoneView: View {
    // Variables
    @State private var selectedOption = "Ask"
    let options = ["Ask", "Deny", "Allow"]
    
    var body: some View {
        CustomList(title: "Microphone") {
            Section {
                ForEach(options, id: \.self) { option in
                    Button {
                        selectedOption = option
                    } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if selectedOption == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
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
