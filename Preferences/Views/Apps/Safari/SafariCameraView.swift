//
//  SafariCameraView.swift
//  Preferences
//
//  Settings > Safari > Camera
//

import SwiftUI

struct SafariCameraView: View {
    // Variables
    @State private var selectedOption = "Ask"
    let options = ["Ask", "Deny", "Allow"]
    
    var body: some View {
        CustomList(title: "Camera") {
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
                Text("Camera Access On All Websites")
            }
        }
        .padding(.top, 19)
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
