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
    
    var body: some View {
        CustomList(title: "Search") {
            Section {
                Toggle("Show Recent Searches", isOn: $showRecentSearchesEnabled)
                Toggle("Show Related Content", isOn: $showRelatedContentEnabled)
            } header: {
                Text("\nSearch and Look Up")
            } footer: {
                Text("Allow content from Apple and other partners to be shown when searching or when looking up text or objects in photos. [About Search & Privacy...](#)")
            }
            
            Section {
                Toggle("Help Apple Improve Search", isOn: $helpImproveSearchEnabled)
            } footer: {
                Text("Help improve Search by allowing Apple to store the searches you enter into Safari, Siri, and Spotlight in a way that is not linked to you.\n\nSearches includes lookups of general knowledge, and requests to do things like play music, and get directions.")
            }
            
            Section {
                SettingsLink(color: .white, icon: "appclip", id: "App Clips") {
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
