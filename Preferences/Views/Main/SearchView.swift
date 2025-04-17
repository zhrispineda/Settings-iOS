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
            // MARK: Search  and Look Up Section
            Section {
                Toggle("SEARCH_AND_LOOKUP_SHOW_RECENTS".localize(table: table), isOn: $showRecentSearches)
                Toggle("SEARCH_AND_LOOKUP_SHOW_RELATED_CONTENT".localize(table: table), isOn: $showRelatedContent)
            } header: {
                Text("SEARCH_AND_LOOKUP_GROUP", tableName: table)
            } footer: {
                Text("\("SEARCH_AND_LOOKUP_FOOTER".localize(table: table)) [\("About Search & Privacy…".localize(table: "SiriSuggestions"))](pref://)")
            }
            
            // MARK: Help Apple Improve Search Section
            Section {
                Toggle("SEARCH_ALLOW_ANONYMOUS_RECORDS".localize(table: table), isOn: $helpImproveSearch)
            } footer: {
                Text("\("SEARCH_ALLOW_ANONYMOUS_RECORDS_FOOTER".localize(table: table)) [\("About Search & Privacy…".localize(table: "SiriSuggestions"))](pref://)")
            }
            
            // MARK: App List Section
            Section {
                SLink("APP_CLIPS".localize(table: table), color: .white, iconColor: .blue, icon: "appclip") {
                    BundleControllerView("/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework/AssistantSettingsSupport", controller: "AssistantAppClipSettingsController", title: "APP_CLIPS", table: table)
                }
                ForEach(apps, id: \.self) { app in
                    SLink(app, icon: "apple\(app)") {
                        SearchDetailView(appName: app)
                    }
                }
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.sirisuggestions")
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
