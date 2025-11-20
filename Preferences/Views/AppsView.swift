//
//  AppsView.swift
//  Preferences
//
//  Settings > Apps
//

import SwiftUI

struct AppInfo {
    let name: String
    let icon: String
    let showOnSimulator: Bool
}

struct AppsView: View {
    @State private var searchText = String()
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
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
    let path = "/System/Library/Settings/InstalledApps.settings"
    
    var body: some View {
        ScrollViewReader { proxy in
            CustomList(title: "Apps".localized(path: path)) {
                // MARK: Default Apps
                Section {
                    SLink("Default Apps".localized(path: path), icon: "com.apple.graphic-icon.default-apps", subtitle: "Manage default apps on device".localized(path: path)) {
                        DefaultAppsView()
                    }
                }
                
                // MARK: Apps
                ForEach(Array(letters), id: \.self) { letter in
                    let key = String(letter)
                    
                    if let apps = groupedApps[key], !apps.isEmpty {
                        Section(key) {
                            ForEach(apps, id: \.name) { app in
                                SLink(app.name, icon: app.icon) {
                                    switch app.name {
                                    case "App Store": AppStoreView()
                                    case "Books": BooksView()
                                    case "Calendar": CalendarView()
                                    case "Contacts": ContactsView()
                                    case "Files": FilesView()
                                    case "Fitness":
                                        BundleControllerView(
                                            "FitnessSettings",
                                            controller: "FitnessSettingsController",
                                            title: "Fitness"
                                        )
                                    case "Health": HealthView()
                                    case "Maps": MapsView()
                                    case "Messages": MessagesView()
                                    case "News": NewsView()
                                    case "Passwords": PasswordsView()
                                    case "Photos": PhotosView()
                                    case "Reminders":
                                        if UIDevice.IsSimulator {
                                            EmptyView()
                                        } else {
                                            RemindersView()
                                        }
                                    case "Safari": SafariView()
                                    case "Shortcuts": ShortcutsView()
                                    case "Translate": TranslateView()
                                    default: EmptyView()
                                    }
                                }
                            }
                        }
                        .sectionIndexLabel(key)
                    }
                }
                
                // MARK: Hidden Apps
                if UIDevice.IsSimulator {
                    Button {} label: {
                        SLink("Hidden Apps".localized(path: path), icon: "com.apple.graphic-icon.hidden-apps") {}
                    }
                    .foregroundStyle(.primary)
                } else {
                    SLink("Hidden Apps".localized(path: path), icon: "com.apple.graphic-icon.hidden-apps") {
                        ContentUnavailableView(
                            "No Hidden Apps".localized(path: path),
                            systemImage: "square.stack.3d.up.slash.fill",
                            description: Text("No hidden apps found.".localized(path: path))
                        )
                    }
                }
            }
            .searchable(text: $searchText, placement: UIDevice.iPhone ? .automatic : .toolbar, prompt: "Search Apps".localized(path: path))
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    NavigationStack {
        AppsView()
    }
}
