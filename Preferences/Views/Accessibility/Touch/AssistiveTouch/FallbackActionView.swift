//
//  FallbackActionView.swift
//  Preferences
//
//  Settings > Accessibility > Touch > AssistiveTouch > Fallback Action
//

import SwiftUI

struct FallbackActionView: View {
    // Variables
    @State private var fallbackActionEnabled = true
    @State private var selected = "Tap"
    let options = ["Tap", "Dwell"]
    
    var body: some View {
        CustomList(title: "MOUSE_POINTER_DWELL_AUTOREVERT") {
            Section(content: {
                Toggle("MOUSE_POINTER_DWELL_AUTOREVERT_ENABLED", isOn: $fallbackActionEnabled)
            }, footer: {
                Text("MOUSE_POINTER_DWELL_AUTOREVERT_FOOTER")
            })
            
            Section {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selected = option
                    }, label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            Image(systemName: "\(selected == option ? "checkmark" : "")")
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FallbackActionView()
    }
}
