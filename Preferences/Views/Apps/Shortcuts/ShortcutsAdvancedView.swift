//
//  ShortcutsAdvancedView.swift
//  Preferences
//
//  Settings > Shortcuts > Advanced
//

import SwiftUI

struct ShortcutsAdvancedView: View {
    @State private var allowRunningScriptsEnabled = false
    @State private var allowSharingLargeAmountsDataEnabled = false
    @State private var allowDeletingWithoutConfirmationEnabled = false
    @State private var allowDeletingLargeAmountsDataEnabled = false
    let path = "/System/Library/PreferenceBundles/ShortcutsSettings.bundle"
    let table = "ShortcutsAdvancedSettings"
    
    var body: some View {
        CustomList(title: "Advanced".localized(path: path, table: table)) {
            Section {
                Toggle("SCRIPTING_SWITCH_LABEL".localized(path: path, table: table), isOn: $allowRunningScriptsEnabled)
            } footer: {
                Text("SCRIPTING_GROUP_FOOTER".localized(path: path, table: table))
            }
            
            Section {
                Toggle("ALLOW_SHARING_LARGE_AMOUNT_OF_DATA_SWITCH_LABEL".localized(path: path, table: table), isOn: $allowSharingLargeAmountsDataEnabled)
            }
            
            Section {
                Toggle("ALLOW_DELETING_WITHOUT_CONFIRMATION_SWITCH_LABEL".localized(path: path, table: table), isOn: $allowDeletingWithoutConfirmationEnabled)
                Toggle("ALLOW_DELETING_LARGE_AMOUNT_OF_DATA_SWITCH_LABEL".localized(path: path, table: table), isOn: $allowDeletingLargeAmountsDataEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ShortcutsAdvancedView()
    }
}
