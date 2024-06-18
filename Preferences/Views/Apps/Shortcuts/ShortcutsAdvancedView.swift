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
    
    var body: some View {
        CustomList(title: "Advanced") {
            Section {
                Toggle("Allow Running Scripts", isOn: $allowRunningScriptsEnabled)
            } footer: {
                Text("When enabled, the actions “Run JavaScript on Web Page“ and “Run SSH Script Over SSH“ can be run.")
            }
            
            Section {
                Toggle("Allow Sharing Large Amounts of Data", isOn: $allowSharingLargeAmountsDataEnabled)
            }
            
            Section {
                Toggle("Allow Deleting Without Confirmation", isOn: $allowDeletingWithoutConfirmationEnabled)
                Toggle("Allow Deleting Large Amounts of Data", isOn: $allowDeletingLargeAmountsDataEnabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ShortcutsAdvancedView()
    }
}
