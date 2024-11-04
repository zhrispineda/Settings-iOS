//
//  ShortcutsAdvancedView.swift
//  Preferences
//
//  Settings > Shortcuts > Advanced
//

import SwiftUI

struct ShortcutsAdvancedView: View {
    // Variables
    @State private var allowRunningScriptsEnabled = false
    @State private var allowSharingLargeAmountsDataEnabled = false
    @State private var allowDeletingWithoutConfirmationEnabled = false
    @State private var allowDeletingLargeAmountsDataEnabled = false
    let table = "ShortcutsAdvancedSettings"
    
    var body: some View {
        CustomList(title: "Advanced".localize(table: table)) {
            Section {
                Toggle("SCRIPTING_SWITCH_LABEL".localize(table: table), isOn: $allowRunningScriptsEnabled)
            } footer: {
                Text("SCRIPTING_GROUP_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("ALLOW_SHARING_LARGE_AMOUNT_OF_DATA_SWITCH_LABEL".localize(table: table), isOn: $allowSharingLargeAmountsDataEnabled)
            }
            
            Section {
                Toggle("ALLOW_DELETING_WITHOUT_CONFIRMATION_SWITCH_LABEL".localize(table: table), isOn: $allowDeletingWithoutConfirmationEnabled)
                Toggle("ALLOW_DELETING_LARGE_AMOUNT_OF_DATA_SWITCH_LABEL".localize(table: table), isOn: $allowDeletingLargeAmountsDataEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ShortcutsAdvancedView()
    }
}
