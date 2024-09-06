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
    let apps = ["Calendar", "Contacts", "Files", "Fitness", "Health", "Maps", "Messages", "News", "Passwords", "Photos", "Reminders", "Safari", "Shortcuts", "Translate", "Watch"]
    let simulatorApps = ["Calendar", "Contacts", "Files", "Fitness", "Health", "Maps", "Messages", "News", "Passwords", "Photos", "Reminders", "Safari", "Shortcuts", "Watch"]
    let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#".map(String.init)
    
    var groupedApps: [String: [String]] {
        Dictionary(grouping: UIDevice.isSimulator ? simulatorApps : apps, by: { String($0.prefix(1)) })
    }

    var body: some View {
        ZStack {
            CustomList(title: "Apps") {
                ForEach(groupedApps.keys.sorted(), id: \.self) { key in
                    Section(header: Text(key)) {
                        ForEach(groupedApps[key]!, id: \.self) { app in
                            SettingsLink(icon: "apple\(app)", id: app) {
                                switch app {
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
                                case "Watch":
                                    WatchView()
                                default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                    .id(key)
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
            
            VStack {
                ForEach(characters, id: \.self) { char in
                    Text(char)
                        .foregroundStyle(.accent)
                        .fontWeight(.semibold)
                        .font(.system(size: 13))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 3)
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
