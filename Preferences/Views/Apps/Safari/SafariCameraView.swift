//
//  SafariCameraView.swift
//  Preferences
//
//  Settings > Safari > Camera
//

import SwiftUI

struct SafariCameraView: View {
    // Variables
    @State private var selected = "Ask"
    let options = ["Ask", "Deny", "Allow"]
    
    var body: some View {
        CustomList(title: "Camera") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
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
