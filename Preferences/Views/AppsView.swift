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
    let apps = ["App Store", "Books", "Calendar", "Contacts", "Files", "Fitness", "Health", "Maps", "Messages", "News", "Passwords", "Photos", "Reminders", "Safari", "Shortcuts", "Translate"]
    let simulatorApps = ["Calendar", "Contacts", "Files", "Fitness", "Health", "Maps", "Messages", "News", "Passwords", "Photos", "Reminders", "Safari", "Shortcuts"]
    var groupedApps: [String: [String]] {
        Dictionary(grouping: UIDevice.IsSimulator ? simulatorApps : apps, by: { String($0.prefix(1)) })
    }
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
    let table = "InstalledApps"
    
    var body: some View {
        ScrollViewReader { proxy in
            CustomList(title: "Apps".localize(table: table)) {
                // MARK: Default Apps
                SettingsLink(color: .gray, icon: "checkmark.rectangle.stack.fill", id: "Default Apps".localize(table: table), subtitle: "Manage default apps on device".localize(table: table)) {
                    DefaultAppsView()
                }
                
                // MARK: Apps
                ForEach(groupedApps.keys.sorted(), id: \.self) { key in
                    Section(key) {
                        ForEach(groupedApps[key]!, id: \.self) { app in
                            SettingsLink(icon: "apple\(app)", id: app) {
                                switch app {
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
                                    FitnessView()
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
                                    RemindersView()
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
                SettingsLink(color: .gray, icon: "square.dashed", id: "Hidden Apps".localize(table: table)) {
                    ContentUnavailableView(
                        "No Hidden Apps".localize(table: table),
                        systemImage: "square.stack.3d.up.slash.fill",
                        description: Text("No hidden apps found.", tableName: table)
                    )
                }
            }
            .searchable(text: $searchText, placement: UIDevice.iPhone ? .navigationBarDrawer(displayMode: .always) : .toolbar)
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
    func destination() -> some View {
        AppsView()
    }
}

#Preview {
    NavigationStack {
        AppsView()
    }
}
