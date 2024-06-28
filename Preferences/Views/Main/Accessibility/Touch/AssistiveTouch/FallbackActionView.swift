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
            Section {
                Toggle("MOUSE_POINTER_DWELL_AUTOREVERT_ENABLED", isOn: $fallbackActionEnabled)
            } footer: {
                Text("MOUSE_POINTER_DWELL_AUTOREVERT_FOOTER")
            }
            
            Picker(selection: $selected, label: EmptyView()) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        FallbackActionView()
    }
}
