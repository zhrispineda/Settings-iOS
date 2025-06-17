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
                SLink("Sounds & Haptics", color: .pink, icon: "speaker.3.fill") {
                    BundleControllerView("/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework/SoundsAndHapticsSettings", controller: "SHSSoundsPrefController", title: "Sounds & Haptics")
                }
                SLink("Notifications", color: .red, icon: "bell.badge.fill") {
                    NotificationsView()
                }
                SLink("Focus", color: .indigo, icon: "moon.fill") {
                    FocusView()
                }
                SLink("Screen Time", color: .indigo, icon: "hourglass") {
                    ScreenTimeView()
                }
            }
            .navigationLinkIndicatorVisibility(.hidden)
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
