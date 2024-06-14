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
    
    var body: some View {
        CustomList(title: "Shortcuts") {
            Section {
                Toggle("iCloud Sync", isOn: $cloudSyncEnabled)
            }
            
            Section {
                Toggle("Private Sharing", isOn: $privateSharingEnabled)
            } footer: {
                Text("Allow receiving shortcuts directly from people in your contacts. Apple cannot verify the authenticity of shortcuts shared privately. [About Shortcuts Sharing & Privacy...](#)")
            }
            
            Section {
                NavigationLink("Advanced", destination: ShortcutsAdvancedView())
            }
            
            Section {
                NavigationLink("Legal Notices", destination: {
                    CustomList(title: "Legal Notices") {}
                })
            }
        }
    }
}

#Preview {
    ShortcutsView()
}
