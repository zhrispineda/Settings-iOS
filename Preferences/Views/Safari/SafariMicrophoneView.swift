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
            Section(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }, label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color(UIColor.label))
                            Spacer()
                            if selectedOption == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    })
                }
            }, header: {
                Text("\n\nMicrophone Access On All Websites")
            })
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
