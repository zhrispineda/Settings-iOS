//
//  SafariCameraView.swift
//  Preferences
//
//  Settings > Safari > Camera
//

import SwiftUI

struct SafariCameraView: View {
    // Variables
    @State private var selectedOption: String? = "Ask"
    let options = ["Ask", "Deny", "Allow"]
    
    var body: some View {
        CustomList(title: "Camera") {
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
                Text("\n\nCamera Access On All Websites")
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
        SafariCameraView()
    }
}