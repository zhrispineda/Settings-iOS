//
//  ShortcutsView.swift
//  Preferences
//
//  Settings > Apps > Shortcuts
//

import SwiftUI

struct ShortcutsView: View {
    @State private var cloudSyncEnabled = true
    @State private var privateSharingEnabled = false
    @State private var showingSheet = false
    let path = "/System/Library/PreferenceBundles/ShortcutsSettings.bundle"
    
    var body: some View {
        CustomList(title: "Shortcuts".localized(path: path)) {
            // iCloud Sync
            Section {
                Toggle("iCloud Sync".localized(path: path), isOn: $cloudSyncEnabled)
            }
            
            // Private Sharing
            Section {
                Toggle("Private Sharing".localized(path: path), isOn: $privateSharingEnabled)
            } footer: {
                Text("\("Allow receiving shortcuts directly from people in your contacts. Apple cannot verify the authenticity of shortcuts shared privately.".localized(path: path)) [\("About Shortcuts Sharing & Privacy…".localized(path: path))](pref://)")
            }
            
            // Advanced
            Section {
                NavigationLink("Advanced".localized(path: path), destination: ShortcutsAdvancedView())
            }
            
            // Legal Notices
            Section {
                NavigationLink("Legal Notices".localized(path: path)) {
                    CustomList(title: "Legal Notices".localized(path: path)) {}
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
