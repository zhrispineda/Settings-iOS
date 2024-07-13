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
        CustomList(title: "AMBIENT_FEATURE_NAME".localize(table: "AmbientSettings")) {
            Section {
                Toggle("AMBIENT_FEATURE_NAME".localize(table: "AmbientSettings"), isOn: $standByEnabled.animation())
            } footer: {
                Text("AMBIENT_MODE_ENABLED_FOOTER".localize(table: "AmbientSettings", "AMBIENT_FEATURE_NAME"))
            }
            
            if standByEnabled {
                if UIDevice.AlwaysOnDisplayCapability {
                    NavigationLink("ALWAYS_ON_DISPLAY_OPTIONS".localize(table: "AmbientSettings"), destination: DisplayView())
                } else {
                    Section {
                        Toggle("NIGHT_MODE_ENABLED".localize(table: "AmbientSettings"), isOn: $nightModeEnabled)
                    } header: {
                        Text("DISPLAY_SETTINGS_GROUP_HEADER", tableName: "AmbientSettings")
                    } footer: {
                        Text("NIGHT_MODE_ENABLED_FOOTER".localize(table: "AmbientSettings", "AMBIENT_FEATURE_NAME"))
                    }
                }
                
                Section {
                    Toggle("NOTIFICATIONS_ENABLED".localize(table: "AmbientSettings"), isOn: $showNotificationsEnabled.animation())
                } header: {
                    Text("NOTIFICATIONS_GROUP_HEADER", tableName: "AmbientSettings")
                } footer: {
                    Text("NOTIFICATIONS_ENABLED_FOOTER".localize(table: "AmbientSettings", "AMBIENT_FEATURE_NAME"))
                }
                
                if showNotificationsEnabled {
                    Section {
                        Toggle("NOTIFICATIONS_PREVIEW".localize(table: "AmbientSettings"), isOn: $showPreviewsTapOnlyEnabled)
                    } footer: {
                        Text("NOTIFICATIONS_PREVIEW_FOOTER".localize(table: "AmbientSettings", "AMBIENT_FEATURE_NAME"))
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
