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
    let apps = ["Books", "Calendar", "Contacts", "Files", "Fitness", "Health", "Maps", "Messages", "News", "Passwords", "Photos", "Reminders", "Safari", "Shortcuts", "Translate"]
    let simulatorApps = ["Calendar", "Contacts", "Files", "Fitness", "Health", "Maps", "Messages", "News", "Passwords", "Photos", "Reminders", "Safari", "Shortcuts"]
    var groupedApps: [String: [String]] {
        Dictionary(grouping: UIDevice.IsSimulator ? simulatorApps : apps, by: { String($0.prefix(1)) })
    }
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#"
    
    var body: some View {
        ScrollViewReader { proxy in
            CustomList(title: "Apps") {
                ForEach(groupedApps.keys.sorted(), id: \.self) { key in
                    Section(key) {
                        ForEach(groupedApps[key]!, id: \.self) { app in
                            SettingsLink(icon: "apple\(app)", id: app) {
                                switch app {
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
                SettingsLink(color: .gray, icon: "square.dashed", id: "Hidden Apps") {
                    ContentUnavailableView(
                        "No Hidden Apps",
                        systemImage: "square.stack.3d.up.slash.fill",
                        description: Text("No hidden apps found.")
                    )
                }
            }
            .searchable(text: $searchText, placement: .toolbar)
            .scrollIndicators(.hidden)
            .toolbar {
                if UIDevice.iPad {
                    ToolbarItem(placement: .principal) {
                        Text(String()) // Keep navigation title for subviews but hide on iPadOS
                    }
                }
            }
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

#Preview {
    NavigationStack {
        AppsView()
    }
}
