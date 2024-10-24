//
//  StickyKeysView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards > Sticky Keys
//

import SwiftUI

struct StickyKeysView: View {
    // Variables
    @State private var stickyKeysEnabled = false
    @State private var toggleWithShiftKey = false
    @State private var soundEnabled = true
    let table = "KeyboardsSettings"
    
    var body: some View {
        CustomList(title: "STICKY_KEYS".localize(table: table)) {
            Section {
                Toggle("STICKY_KEYS".localize(table: table), isOn: $stickyKeysEnabled)
            } footer: {
                Text("STICKY_KEYS_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("STICKY_KEYS_SHIFT_TOGGLE".localize(table: table), isOn: $toggleWithShiftKey)
            } footer: {
                Text("STICKY_KEYS_SHIFT_TOGGLE_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("STICKY_KEYS_BEEP".localize(table: table), isOn: $soundEnabled)
            } footer: {
                Text("STICKY_KEYS_BEEP_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        StickyKeysView()
    }
}
