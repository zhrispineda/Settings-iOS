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
                SLink("Sounds & Haptics", icon: "com.apple.graphic-icon.sound") {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework/SoundsAndHapticsSettings", controller: "SHSSoundsPrefController", title: "Sounds & Haptics")
                }
                SLink("Notifications", icon: "com.apple.graphic-icon.notifications") {
                    NotificationsView()
                }
                SLink("Focus", icon: "com.apple.graphic-icon.focus") {
                    FocusView()
                }
                SLink("Screen Time", icon: "com.apple.graphic-icon.screen-time") {
                    ScreenTimeView()
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
