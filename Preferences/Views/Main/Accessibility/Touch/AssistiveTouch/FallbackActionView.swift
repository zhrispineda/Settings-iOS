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
    @State private var selected = "TAP"
    let options = ["TAP", "DWELL"]
    let table = "HandSettings"
    let strTable = "LocalizedStrings"
    
    var body: some View {
        CustomList(title: "MOUSE_POINTER_DWELL_AUTOREVERT".localize(table: table)) {
            Section {
                Toggle("MOUSE_POINTER_DWELL_AUTOREVERT_ENABLED".localize(table: table), isOn: $fallbackActionEnabled)
            } footer: {
                Text("MOUSE_POINTER_DWELL_AUTOREVERT_FOOTER", tableName: table)
            }
            
            Picker(selection: $selected, label: EmptyView()) {
                ForEach(options, id: \.self) { option in
                    Text(option.localize(table: strTable))
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
