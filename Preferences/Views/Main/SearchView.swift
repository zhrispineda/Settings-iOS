//
//  SearchView.swift
//  Preferences
//
//  Settings > Search
//

import SwiftUI

struct SearchView: View {
    // Variables
    let apps = ["Calendar", "Contacts", "Files", "Health", "Maps", "Messages", "News", "Photos", "Reminders", "Safari", "Settings", "Wallet"]
    
    @State private var showRecentSearchesEnabled = true
    @State private var showRelatedContentEnabled = true
    @State private var helpImproveSearchEnabled = false
    let table = "SpotlightSettings"
    let assistTable = "AssistantSettings"
    
    var body: some View {
        CustomList(title: "SEARCH".localize(table: table), topPadding: true) {
            Section {
                Toggle("SEARCH_AND_LOOKUP_SHOW_RECENTS".localize(table: table), isOn: $showRecentSearchesEnabled)
                Toggle("SEARCH_AND_LOOKUP_SHOW_RELATED_CONTENT".localize(table: table), isOn: $showRelatedContentEnabled)
            } header: {
                Text("SEARCH_AND_LOOKUP_GROUP", tableName: table)
            } footer: {
                Text("SEARCH_AND_LOOKUP_FOOTER", tableName: table) + Text(" [\("BUTTON_TITLE".localize(table: "SiriSuggestions"))](#)")
            }
            
            Section {
                Toggle("SEARCH_ALLOW_ANONYMOUS_RECORDS".localize(table: table), isOn: $helpImproveSearchEnabled)
            } footer: {
                Text("SEARCH_ALLOW_ANONYMOUS_RECORDS_FOOTER", tableName: table)
            }
            
            Section {
                SettingsLink(color: .white, iconColor: .blue, icon: "appclip", id: "APP_CLIPS".localize(table: table)) {
                    SiriAppClipsView()
                }
                ForEach(apps, id: \.self) { app in
                    SettingsLink(icon: "apple\(app)", id: app) {
                        SearchDetailView(appName: app)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
