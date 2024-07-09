//
//  StandByView.swift
//  Preferences
//
//  Settings > StandBy
//

import SwiftUI

struct StandByView: View {
    // Variables
    @State private var standByEnabled = true
    @State private var nightModeEnabled = true
    @State private var showNotificationsEnabled = true
    @State private var showPreviewsTapOnlyEnabled = false
    
    var body: some View {
        CustomList(title: String(localized: "AMBIENT_FEATURE_NAME", table: "AmbientSettings")) {
            Section {
                Toggle(String(localized: "AMBIENT_FEATURE_NAME", table: "AmbientSettings"), isOn: $standByEnabled.animation())
            } footer: {
                Text(String.localizedStringWithFormat(NSLocalizedString("AMBIENT_MODE_ENABLED_FOOTER", tableName: "AmbientSettings", comment: ""), String(localized: "AMBIENT_FEATURE_NAME", table: "AmbientSettings")))
            }
            
            if standByEnabled {
                if Device().hasAlwaysOnDisplay {
                    NavigationLink(String(localized: "ALWAYS_ON_DISPLAY_OPTIONS", table: "AmbientSettings"), destination: DisplayView())
                } else {
                    Section {
                        Toggle(String(localized: "NIGHT_MODE_ENABLED", table: "AmbientSettings"), isOn: $nightModeEnabled)
                    } header: {
                        Text("DISPLAY_SETTINGS_GROUP_HEADER", tableName: "AmbientSettings")
                    } footer: {
                        Text(String.localizedStringWithFormat(NSLocalizedString("NIGHT_MODE_ENABLED_FOOTER", tableName: "AmbientSettings", comment: ""), String(localized: "AMBIENT_FEATURE_NAME", table: "AmbientSettings")))
                    }
                }
                
                Section {
                    Toggle(String(localized: "NOTIFICATIONS_ENABLED", table: "AmbientSettings"), isOn: $showNotificationsEnabled.animation())
                } header: {
                    Text("NOTIFICATIONS_GROUP_HEADER", tableName: "AmbientSettings")
                } footer: {
                    Text(String.localizedStringWithFormat(NSLocalizedString("NOTIFICATIONS_ENABLED_FOOTER", tableName: "AmbientSettings", comment: ""), String(localized: "AMBIENT_FEATURE_NAME", table: "AmbientSettings")))
                }
                
                if showNotificationsEnabled {
                    Section {
                        Toggle(String(localized: "NOTIFICATIONS_PREVIEW", table: "AmbientSettings"), isOn: $showPreviewsTapOnlyEnabled)
                    } footer: {
                        Text(String.localizedStringWithFormat(NSLocalizedString("NOTIFICATIONS_PREVIEW_FOOTER", tableName: "AmbientSettings", comment: ""), String(localized: "AMBIENT_FEATURE_NAME", table: "AmbientSettings")))
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
