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
    let table = "InstalledApps"
    
    var body: some View {
        ScrollViewReader { proxy in
            CustomList(title: "Apps".localize(table: table)) {
                // MARK: Default Apps
                Section {
                    SLink("Default Apps".localize(table: table), icon: "com.apple.graphic-icon.default-apps", subtitle: "Manage default apps on device".localize(table: table)) {
                        DefaultAppsView()
                    }
                }

                // MARK: Apps
                ForEach(groupedApps.keys.sorted(), id: \.self) { key in
                    Section(key) {
                        ForEach(groupedApps[key]!, id: \.name) { app in
                            SLink(app.name, icon: app.icon) {
                                switch app.name {
                                case "App Store":
                                    AppStoreView()
                                case "Books":
                                    BooksView()
                                case "Calendar":
                                    CalendarView()
                                case "Contacts":
                                    ContactsView()
                                case "Files":
                                    FilesView()
                                case "Fitness":
                                    EmptyView()
                                case "Health":
                                    HealthView()
                                case "Maps":
                                    MapsView()
                                case "Messages":
                                    MessagesView()
                                case "News":
                                    NewsView()
                                case "Passwords":
                                    PasswordsView()
                                case "Photos":
                                    PhotosView()
                                case "Reminders":
                                    if UIDevice.IsSimulator {
                                        EmptyView()
                                    } else {
                                        RemindersView()
                                    }
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
                
                // MARK: Hidden Apps
                if UIDevice.IsSimulator {
                    Button {} label: {
                        SLink("Hidden Apps".localize(table: table), icon: "com.apple.graphic-icon.hidden-apps") {}
                    }
                    .foregroundStyle(.primary)
                } else {
                    SLink("Hidden Apps".localize(table: table), icon: "com.apple.graphic-icon.hidden-apps") {
                        ContentUnavailableView(
                            "No Hidden Apps".localize(table: table),
                            systemImage: "square.stack.3d.up.slash.fill",
                            description: Text("No hidden apps found.", tableName: table)
                        )
                    }
                }
            }
            .searchable(text: $searchText, placement: UIDevice.iPhone ? .automatic : .toolbar, prompt: "Search Apps")
            .scrollIndicators(.hidden)
            .overlay {
                HStack {
                    Spacer()
                    VStack(spacing: 0) {
                        ForEach(Array(letters), id: \.self) { letter in
                            Text(String(letter))
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.blue)
                                .frame(width: 20, height: 15)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if groupedApps[String(letter)] != nil {
                                        proxy.scrollTo(String(letter), anchor: .top)
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct AppsRoute: Routable {
    func destination() -> AnyView {
        AnyView(AppsView())
    }
}

#Preview {
    NavigationStack {
        AppsView()
    }
}
