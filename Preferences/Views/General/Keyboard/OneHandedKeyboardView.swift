//
//  OneHandedKeyboardView.swift
//  Preferences
//
//  Settings > General > Keyboard > One-Handed Keyboard
//

import SwiftUI

struct OneHandedKeyboardView: View {
    // Variables
    @State private var selected = "Off"
    let options = ["Off", "Left", "Right"]
    
    var body: some View {
        CustomList(title: "One-Handed Keyboard") {
            Section(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selected = option
                    }, label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color(UIColor.label))
                            Spacer()
                            Image(systemName: "\(selected == option ? "checkmark" : "")")
                        }
                    })
                }
            }, footer: {
                Text("You can quickly access these settings by pressing and holding the Emoji or Globe key on the keyboard.")
            })
        }
    }
}

#Preview {
    OneHandedKeyboardView()
}
