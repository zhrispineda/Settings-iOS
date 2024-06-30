//
//  SafariLocationView.swift
//  Preferences
//
//  Settings > Safari > Location
//

import SwiftUI

struct SafariLocationView: View {
    // Variables
    @State private var selectedOption: String? = "Ask"
    let options = ["Ask", "Deny", "Allow"]
    
    var body: some View {
        CustomList(title: "Location") {
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
