//
//  AppsView.swift
//  Preferences
//
//  Settings > Apps
//

import SwiftUI

struct AppsView: View {
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
                SLink("Default Apps".localize(table: table), color: .gray, icon: "checkmark.rectangle.stack.fill", subtitle: "Manage default apps on device".localize(table: table)) {
                    DefaultAppsView()
                }
                
                // MARK: Apps
                ForEach(groupedApps.keys.sorted(), id: \.self) { key in
                    Section(key) {
                        ForEach(groupedApps[key]!, id: \.self) { app in
                            SLink(app, icon: "apple\(app)") {
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
                                    BundleControllerView("FitnessSettings", controller: "FitnessSettingsController", title: "Fitness")
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
                        SLink("Hidden Apps".localize(table: table), color: .gray, icon: "square.dashed") {}
                    }
                    .foregroundStyle(.primary)
                } else {
                    SLink("Hidden Apps".localize(table: table), color: .gray, icon: "square.dashed") {
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
