//
//  AppsView.swift
//  Preferences
//
//  Settings > Apps
//

import SwiftUI

struct AppsView: View {
    // Variables
    @State private var searchText = String()
    
    let apps = ["Calendar", "Contacts", "Files", "Health", "Maps", "Messages", "News", "Photos", "Reminders", "Safari", "Settings", "Wallet", "Watch"]

    var groupedApps: [String: [String]] {
        Dictionary(grouping: apps, by: { String($0.prefix(1)) })
    }

    var body: some View {
        CustomList(title: "Apps") {
            ForEach(groupedApps.keys.sorted(), id: \.self) { key in
                Section(header: Text(key)) {
                    ForEach(groupedApps[key]!, id: \.self) { app in
                        SettingsLink(icon: "apple\(app)", id: app) {}
                    }
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
}


#Preview {
    NavigationStack {
        AppsView()
    }
}
