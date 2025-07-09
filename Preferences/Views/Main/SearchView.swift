//
//  SearchView.swift
//  Preferences
//
//  Settings > Search
//

import SwiftUI

struct SearchView: View {
    @AppStorage("ShowRecentSearchesToggle") private var showRecentSearches = true
    @AppStorage("ShowRelatedContentToggle") private var showRelatedContent = true
    @AppStorage("HelpImproveSearchToggle") private var helpImproveSearch = true
    @State private var showingSheet = false
    let apps = [
        AppInfo(name: "App Store", icon: "com.apple.AppStore", showOnSimulator: false),
        AppInfo(name: "Books", icon: "com.apple.iBooks", showOnSimulator: false),
        AppInfo(name: "Calendar", icon: "com.apple.mobilecal", showOnSimulator: true),
        AppInfo(name: "Contacts", icon: "com.apple.MobileAddressBook", showOnSimulator: true),
        AppInfo(name: "Files", icon: "com.apple.DocumentsApp", showOnSimulator: true),
        AppInfo(name: "Fitness", icon: "com.apple.Fitness", showOnSimulator: true),
        AppInfo(name: "Health", icon: "com.apple.Health", showOnSimulator: true),
        AppInfo(name: "Maps", icon: "com.apple.Maps", showOnSimulator: true),
        AppInfo(name: "Messages", icon: "com.apple.MobileSMS", showOnSimulator: true),
        AppInfo(name: "News", icon: "com.apple.news", showOnSimulator: true),
        AppInfo(name: "Passwords", icon: "com.apple.Passwords", showOnSimulator: true),
        AppInfo(name: "Photos", icon: "com.apple.mobileslideshow", showOnSimulator: true),
        AppInfo(name: "Reminders", icon: "com.apple.reminders", showOnSimulator: true),
        AppInfo(name: "Safari", icon: "com.apple.mobilesafari", showOnSimulator: true),
        AppInfo(name: "Shortcuts", icon: "com.apple.shortcuts", showOnSimulator: true),
        AppInfo(name: "Wallet", icon: "com.apple.Passbook", showOnSimulator: true),
        AppInfo(name: "Translate", icon: "com.apple.Translate", showOnSimulator: false)
    ]
    var groupedApps: [String: [AppInfo]] {
        let filteredApps = UIDevice.IsSimulated ? apps.filter { $0.showOnSimulator } : apps
        return Dictionary(grouping: filteredApps, by: { String($0.name.prefix(1)) })
    }
    let path = "/System/Library/PrivateFrameworks/SpotlightSettingsSupport.framework"
    let privacy = "/System/Library/OnBoardingBundles/com.apple.onboarding.sirisuggestions.bundle"
    let table = "SpotlightSettings"
    
    var body: some View {
        CustomList(title: "SEARCH".localized(path: path, table: table), topPadding: true) {
            // MARK: Search  and Look Up Section
            Section {
                Toggle("SEARCH_AND_LOOKUP_SHOW_RECENTS".localized(path: path, table: table), isOn: $showRecentSearches)
                Toggle("SEARCH_AND_LOOKUP_SHOW_RELATED_CONTENT".localized(path: path, table: table), isOn: $showRelatedContent)
            } header: {
                Text("SEARCH_AND_LOOKUP_GROUP".localized(path: path, table: table))
            } footer: {
                Text("\("SEARCH_AND_LOOKUP_FOOTER".localized(path: path, table: table)) [\("BUTTON_TITLE".localized(path: privacy, table: "SiriSuggestions"))](pref://)")
            }
            
            // MARK: Help Apple Improve Search Section
            Section {
                Toggle("SEARCH_ALLOW_ANONYMOUS_RECORDS".localized(path: path, table: table), isOn: $helpImproveSearch)
            } footer: {
                Text("\("SEARCH_ALLOW_ANONYMOUS_RECORDS_FOOTER".localized(path: path, table: table)) [\("BUTTON_TITLE".localized(path: privacy, table: "SiriSuggestions"))](pref://)")
            }
            
            // MARK: App List Section
            Section {
                SLink("APP_CLIPS".localized(path: path, table: table), icon: "com.apple.graphic-icon.app-clips") {
                    BundleControllerView("/System/Library/PrivateFrameworks/AssistantSettingsSupport.framework/AssistantSettingsSupport", controller: "AssistantAppClipSettingsController", title: "APP_CLIPS", table: table)
                }
                ForEach(groupedApps.keys.sorted(), id: \.self) { key in
                    ForEach(groupedApps[key]!, id: \.name) { app in
                        SLink(app.name, icon: app.icon) {
                            SearchDetailView(appName: app.name)
                        }
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
