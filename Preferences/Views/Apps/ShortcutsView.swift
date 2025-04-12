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
    @State private var showingSheet = false
    let table = "ShortcutsSettings"
    
    var body: some View {
        CustomList(title: "Shortcuts") {
            // iCloud Sync
            Section {
                Toggle("iCloud Sync".localize(table: table), isOn: $cloudSyncEnabled)
            }
            
            // Private Sharing
            Section {
                Toggle("Private Sharing".localize(table: table), isOn: $privateSharingEnabled)
            } footer: {
                Text("Allow receiving shortcuts directly from people in your contacts. Apple cannot verify the authenticity of shortcuts shared privately.", tableName: table) + Text(" [\("About Shortcuts Sharing & Privacy…".localize(table: table))](pref://)")
            }
            
            // Advanced
            Section {
                NavigationLink("Advanced".localize(table: table), destination: ShortcutsAdvancedView())
            }
            
            // Legal Notices
            Section {
                NavigationLink("Legal Notices".localize(table: table)) {
                    CustomList(title: "Legal Notices".localize(table: table)) {}
                }
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.shortcutssharing")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        ShortcutsView()
    }
}
