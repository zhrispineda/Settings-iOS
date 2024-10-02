//
//  StandByView.swift
//  Preferences
//
//  Settings > StandBy
//

import SwiftUI

struct StandByView: View {
    // Variables
    @AppStorage("AmbientEnabledSetting") private var standByEnabled = true
    @AppStorage("AmbientNightSetting") private var nightModeEnabled = true
    @AppStorage("AmbientNotificationSetting") private var showNotificationsEnabled = true
    @AppStorage("AmbientPreviewSetting") private var showPreviewsTapOnlyEnabled = false
    let table = "AmbientSettings"
    
    var body: some View {
        CustomList(title: "AMBIENT_FEATURE_NAME".localize(table: table)) {
            Section {
                Toggle("AMBIENT_FEATURE_NAME".localize(table: table), isOn: $standByEnabled.animation())
            } footer: {
                Text("AMBIENT_MODE_ENABLED_FOOTER".localize(table: table, "AMBIENT_FEATURE_NAME"))
            }
            
            if standByEnabled {
                if UIDevice.AlwaysOnDisplayCapability {
                    NavigationLink("ALWAYS_ON_DISPLAY_OPTIONS".localize(table: table), destination: DisplayView())
                } else {
                    Section {
                        Toggle("NIGHT_MODE_ENABLED".localize(table: table), isOn: $nightModeEnabled)
                    } header: {
                        Text("DISPLAY_SETTINGS_GROUP_HEADER", tableName: table)
                    } footer: {
                        Text("NIGHT_MODE_ENABLED_FOOTER".localize(table: table, "AMBIENT_FEATURE_NAME"))
                    }
                }
                
                Section {
                    Toggle("NOTIFICATIONS_ENABLED".localize(table: table), isOn: $showNotificationsEnabled.animation())
                } header: {
                    Text("NOTIFICATIONS_GROUP_HEADER", tableName: table)
                } footer: {
                    Text("NOTIFICATIONS_ENABLED_FOOTER".localize(table: table, "AMBIENT_FEATURE_NAME"))
                }
                
                if showNotificationsEnabled {
                    Section {
                        Toggle("NOTIFICATIONS_PREVIEW".localize(table: table), isOn: $showPreviewsTapOnlyEnabled)
                    } footer: {
                        Text("NOTIFICATIONS_PREVIEW_FOOTER".localize(table: table, "AMBIENT_FEATURE_NAME"))
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        StandByView()
    }
}
