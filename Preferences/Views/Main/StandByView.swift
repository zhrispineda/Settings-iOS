//
//  StandByView.swift
//  Preferences
//
//  Settings > StandBy
//

import SwiftUI

struct StandByView: View {
    @AppStorage("AmbientEnabledSetting") private var standByEnabled = true
    @AppStorage("AmbientNightSetting") private var nightModeEnabled = true
    @AppStorage("AmbientNotificationSetting") private var showNotificationsEnabled = true
    @AppStorage("AmbientPreviewSetting") private var showPreviewsTapOnlyEnabled = false
    let path = "/System/Library/PreferenceBundles/AmbientSettings.bundle"
    let table = "AmbientSettings"
    
    var body: some View {
        CustomList(title: "AMBIENT_FEATURE_NAME".localized(path: path, table: table)) {
            Section {
                Toggle("AMBIENT_FEATURE_NAME".localized(path: path, table: table), isOn: $standByEnabled.animation())
            } footer: {
                Text("AMBIENT_MODE_ENABLED_FOOTER".localized(path: path, table: table, "AMBIENT_FEATURE_NAME".localized(path: path, table: table)))
            }
            
            if standByEnabled {
                if UIDevice.AlwaysOnDisplayCapability {
                    NavigationLink("ALWAYS_ON_DISPLAY_OPTIONS".localized(path: path, table: table), destination: DisplayView())
                } else {
                    Section {
                        Toggle("NIGHT_MODE_ENABLED".localized(path: path, table: table), isOn: $nightModeEnabled)
                    } header: {
                        Text("DISPLAY_SETTINGS_GROUP_HEADER".localized(path: path, table: table))
                    } footer: {
                        Text("NIGHT_MODE_ENABLED_FOOTER".localized(path: path, table: table))
                    }
                }
                
                Section {
                    Toggle("NOTIFICATIONS_ENABLED".localized(path: path, table: table), isOn: $showNotificationsEnabled.animation())
                } header: {
                    Text("NOTIFICATIONS_GROUP_HEADER".localized(path: path, table: table))
                } footer: {
                    Text("NOTIFICATIONS_ENABLED_FOOTER".localized(path: path, table: table, "AMBIENT_FEATURE_NAME".localized(path: path, table: table)))
                }
                
                if showNotificationsEnabled {
                    Section {
                        Toggle("NOTIFICATIONS_PREVIEW".localized(path: path, table: table), isOn: $showPreviewsTapOnlyEnabled)
                    } footer: {
                        Text("NOTIFICATIONS_PREVIEW_FOOTER".localized(path: path, table: table, "AMBIENT_FEATURE_NAME".localized(path: path, table: table)))
                    }
                }
            }
        }
        .animation(.default, value: standByEnabled)
        .animation(.default, value: showNotificationsEnabled)
    }
}

#Preview {
    NavigationStack {
        StandByView()
    }
}
