//
//  ShortcutsView.swift
//  Preferences
//
//  Settings > Apps > Shortcuts
//

import SwiftUI

struct ShortcutsView: View {
    // Variables
    @State private var cloudSyncEnabled = true
    @State private var privateSharingEnabled = false
    let table = "ShortcutsSettings"
    
    var body: some View {
        CustomList(title: "Shortcuts") {
            Section {
                Toggle("iCloud Sync".localize(table: table), isOn: $cloudSyncEnabled)
            }
            
            Section {
                Toggle("Private Sharing".localize(table: table), isOn: $privateSharingEnabled)
            } footer: {
                Text("Allow receiving shortcuts directly from people in your contacts. Apple cannot verify the authenticity of shortcuts shared privately.", tableName: table) + Text(" [\("About Shortcuts Sharing & Privacy…".localize(table: table))](#)")
            }
            
            Section {
                NavigationLink("Advanced".localize(table: table), destination: ShortcutsAdvancedView())
            }
            
            Section {
                NavigationLink("Legal Notices".localize(table: table)) {
                    CustomList(title: "Legal Notices".localize(table: table)) {}
                }
            }
        }
    }
}

#Preview {
    ShortcutsView()
}
