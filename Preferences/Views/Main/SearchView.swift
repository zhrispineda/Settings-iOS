//
//  SearchView.swift
//  Preferences
//
//  Settings > Search
//

import SwiftUI

struct SearchView: View {
    // Variables
    let apps = ["Books", "Calendar", "Contacts", "Files", "Health", "Maps", "Messages", "News", "Photos", "Reminders", "Safari", "Settings", "Wallet"]
    
    @AppStorage("ShowRecentSearchesToggle") private var showRecentSearches = true
    @AppStorage("ShowRelatedContentToggle") private var showRelatedContent = true
    @AppStorage("HelpImproveSearchToggle") private var helpImproveSearch = true
    @State private var showingSheet = false
    let table = "SpotlightSettings"
    let assistTable = "AssistantSettings"
    
    var body: some View {
        CustomList(title: "SEARCH".localize(table: table), topPadding: true) {
            Section {
                Toggle("SEARCH_AND_LOOKUP_SHOW_RECENTS".localize(table: table), isOn: $showRecentSearches)
                Toggle("SEARCH_AND_LOOKUP_SHOW_RELATED_CONTENT".localize(table: table), isOn: $showRelatedContent)
            } header: {
                Text("SEARCH_AND_LOOKUP_GROUP", tableName: table)
            } footer: {
                Text("SEARCH_AND_LOOKUP_FOOTER", tableName: table) + Text(" [\("BUTTON_TITLE".localize(table: "SiriSuggestions"))](spotlightSettingsOBK://)")
            }
            .onOpenURL { url in
                if url.scheme == "spotlightSettingsOBK" {
                    showingSheet = true
                }
            }
            .sheet(isPresented: $showingSheet) {
                OnBoardingView(table: "SiriSuggestions")
            }
            
            Section {
                Toggle("SEARCH_ALLOW_ANONYMOUS_RECORDS".localize(table: table), isOn: $helpImproveSearch)
            } footer: {
                Text("SEARCH_ALLOW_ANONYMOUS_RECORDS_FOOTER", tableName: table) + Text(" [\("BUTTON_TITLE".localize(table: "SiriSuggestions"))](spotlightSettingsOBK://)")
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
