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
    
    let simulatorApps = ["Calendar", "Contacts", "Files", "Fitness", "Health", "Maps", "Messages", "News", "Passwords", "Photos", "Reminders", "Safari", "Shortcuts", "Watch"]
    let apps = ["Calendar", "Contacts", "Files", "Fitness", "Health", "Maps", "Messages", "News", "Passwords", "Photos", "Reminders", "Safari", "Shortcuts", "Translate", "Wallet", "Watch"]

    var groupedApps: [String: [String]] {
        Dictionary(grouping: !Configuration().isSimulator ? simulatorApps : apps, by: { String($0.prefix(1)) })
    }

    var body: some View {
        CustomList(title: "Apps") {
            ForEach(groupedApps.keys.sorted(), id: \.self) { key in
                Section(header: Text(key)) {
                    ForEach(groupedApps[key]!, id: \.self) { app in
                        SettingsLink(icon: "apple\(app)", id: app) {
                            switch app {
                            case "Health":
                                HealthView()
                            case "Maps":
                                MapsView()
                            case "News":
                                NewsView()
                            case "Photos":
                                PhotosView()
                            case "Safari":
                                SafariView()
                            case "Shortcuts":
                                ShortcutsView()
                            case "Translate":
                                TranslateView()
                            default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
            SettingsLink(color: .blue, icon: "square.stack.3d.up.slash.fill", id: "Hidden Apps") {}
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
}


#Preview {
    NavigationStack {
        AppsView()
    }
}
