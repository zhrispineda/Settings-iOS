//
//  SearchView.swift
//  Preferences
//
//  Settings > Search
//

import SwiftUI

struct SettingsSearchView: View {
    var stateManager: StateManager

    var body: some View {
        Section("Suggestions") {
            Group {
                NavigationLink {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework/SoundsAndHapticsSettings", controller: "SHSSoundsPrefController", title: "Sounds & Haptics")
                } label: {
                    SLabel("Sounds & Haptics", icon: "com.apple.graphic-icon.sound")
                }
                NavigationLink {
                    NotificationsView()
                } label: {
                    SLabel("Notifications", icon: "com.apple.graphic-icon.notifications")
                }
                NavigationLink {
                    FocusView()
                } label: {
                    SLabel("Focus", icon: "com.apple.graphic-icon.focus")
                }
                NavigationLink {
                    ScreenTimeView()
                } label: {
                    SLabel("Screen Time", icon: "com.apple.graphic-icon.screen-time")
                }
            }
            .navigationLinkIndicatorVisibility(.hidden)
            .padding(.vertical, 5)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            SettingsSearchView(stateManager: StateManager())
        }
    }
}
