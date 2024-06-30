//
//  HeadphoneAudioLevelsView.swift
//  NanoSettings
//
//  Settings > Privacy & Security > Health > Headphone Audio Levels
//

import SwiftUI

struct HeadphoneAudioLevelsView: View {
    @State private var selected = "Until I Delete"
    let options = ["For 8 Days", "Until I Delete"]
    
    var body: some View {
        CustomList(title: "Headphone Audio Levels") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } header: {
                Text("Save In Health")
            } footer: {
                Text("Your device does not record or save any sound to measure audio levels.")
            }
            
            if selected == "For 8 Days" {
                Section {} footer: {
                    Text("This data must be saved for eight days to provide notifications that may protect your hearing. The data will be deleted after eight days.")
                }
            }
        }
    }
}

#Preview {
    HeadphoneAudioLevelsView()
}
