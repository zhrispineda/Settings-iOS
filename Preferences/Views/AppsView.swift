//
//  AppsView.swift
//  Preferences
//
//  Settings > Apps
//

import SwiftUI

/// View for Settings > Apps
///
/// Only hides app links in Simulator/Preview, even if the corresponding bundles exist in the filesystem for Simulator.
struct AppsView: View {
    @State private var searchText = ""
    private let apps = [
        AppInfo(name: "App Store", icon: "com.apple.AppStore", showOnSimulator: false),
        AppInfo(name: "Books", icon: "com.apple.iBooks", showOnSimulator: false),
        AppInfo(name: "Calendar", icon: "com.apple.mobilecal", showOnSimulator: true),
        AppInfo(name: "Compass", icon: "com.apple.compass", showOnSimulator: false),
        AppInfo(name: "Contacts", icon: "com.apple.MobileAddressBook", showOnSimulator: true),
        AppInfo(name: "FaceTime", icon: "com.apple.facetime", showOnSimulator: false),
        AppInfo(name: "Files", icon: "com.apple.DocumentsApp", showOnSimulator: true),
        AppInfo(name: "Fitness", icon: "com.apple.Fitness", showOnSimulator: true),
        AppInfo(name: "Freeform", icon: "com.apple.freeform", showOnSimulator: false),
        AppInfo(name: "Health", icon: "com.apple.Health", showOnSimulator: true),
        AppInfo(name: "Mail", icon: "com.apple.mobilemail", showOnSimulator: false),
        AppInfo(name: "Maps", icon: "com.apple.Maps", showOnSimulator: true),
        AppInfo(name: "Measure", icon: "com.apple.measure", showOnSimulator: false),
        AppInfo(name: "Messages", icon: "com.apple.MobileSMS", showOnSimulator: true),
        AppInfo(name: "Music", icon: "com.apple.Music", showOnSimulator: false),
        AppInfo(name: "News", icon: "com.apple.news", showOnSimulator: true),
        AppInfo(name: "Notes", icon: "com.apple.mobilenotes", showOnSimulator: false),
        AppInfo(name: "Passwords", icon: "com.apple.Passwords", showOnSimulator: true),
        AppInfo(name: "Photos", icon: "com.apple.mobileslideshow", showOnSimulator: true),
        AppInfo(name: "Preview", icon: "com.apple.Preview", showOnSimulator: true),
        AppInfo(name: "Podcasts", icon: "com.apple.podcasts", showOnSimulator: false),
        AppInfo(name: "Reminders", icon: "com.apple.reminders", showOnSimulator: true),
        AppInfo(name: "Safari", icon: "com.apple.mobilesafari", showOnSimulator: true),
        AppInfo(name: "Shortcuts", icon: "com.apple.shortcuts", showOnSimulator: true),
        AppInfo(name: "Stocks", icon: "com.apple.stocks", showOnSimulator: false),
        AppInfo(name: "Translate", icon: "com.apple.Translate", showOnSimulator: false),
        AppInfo(name: "TV", icon: "com.apple.tv", showOnSimulator: false),
        AppInfo(name: "Voice Memos", icon: "com.apple.VoiceMemos", showOnSimulator: false),
        AppInfo(name: "Wallet", icon: "com.apple.Passbook", showOnSimulator: true),
        AppInfo(name: "Weather", icon: "com.apple.weather", showOnSimulator: false)
    ]
    private let path = "/System/Library/Settings/InstalledApps.settings"
    private var visibleApps: [AppInfo] {
        UIDevice.IsSimulated ? apps.filter { $0.showOnSimulator } : apps
    }
    private var filteredApps: [AppInfo] {
        guard !searchText.isEmpty else { return visibleApps }
        return visibleApps.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    private var groupedApps: [String: [AppInfo]] {
        Dictionary(grouping: filteredApps) { String($0.name.prefix(1)) }
    }
    private var sortedKeys: [String] {
        groupedApps.keys.sorted()
    }
    
    var body: some View {
        CustomList(title: "Apps".localized(path: path)) {
            // MARK: Default Apps
            if searchText.isEmpty {
                Section {
                    SLink("Default Apps".localized(path: path),
                          icon: "com.apple.graphic-icon.default-apps",
                          subtitle: "Manage default apps on device".localized(path: path),
                          destination: DefaultAppsView()
                    )
                }
            } else if groupedApps.isEmpty {
                ContentUnavailableView.search(text: searchText)
                    .listRowBackground(Color.clear)
            }
            
            // MARK: Apps
            ForEach(groupedApps.keys.sorted(), id: \.self) { key in
                if let apps = groupedApps[key] {
                    Section(key) {
                        ForEach(apps, id: \.name) { app in
                            SLink(app.name, icon: app.icon) {
                                switch app.name {
                                case "App Store": AppStoreView()
                                case "Books": BooksView()
                                case "Calendar": CalendarView()
                                case "Compass":
                                    ControllerBridgeView(
                                        "CompassSettings",
                                        controller: "CompassSettingsController",
                                        title: "Compass"
                                    )
                                case "Contacts": ContactsView()
                                case "FaceTime":
                                    ControllerBridgeView(
                                        "/System/Library/PrivateFrameworks/CommunicationsSetupUI.framework/CommunicationsSetupUI",
                                        controller: "CNFRegAppleIDSplashViewController",
                                        title: "FaceTime"
                                    )
                                case "Files": FilesView()
                                case "Fitness": FitnessView()
                                case "Freeform":
                                    ControllerBridgeView(
                                        "FreeformSettings",
                                        controller: "CRLSettingsController",
                                        title: "Freeform"
                                    )
                                case "Health": HealthView()
                                case "Mail":
                                    ControllerBridgeView(
                                        "MobileMailSettings",
                                        controller: "MailSettingsPlugin",
                                        title: "Mail"
                                    )
                                case "Maps": MapsView()
                                case "Measure":
                                    ControllerBridgeView(
                                        "MeasureSettings",
                                        controller: "MeasureSettingsController",
                                        title: "Measure"
                                    )
                                case "Messages": MessagesView()
                                case "Music":
                                    ControllerBridgeView(
                                        "MusicSettings",
                                        controller: "MusicSettingsController",
                                        title: "Music"
                                    )
                                case "News": NewsView()
                                case "Notes":
                                    ControllerBridgeView(
                                        "NotesSettings",
                                        controller: "ICSettingsPlugin",
                                        title: "Notes"
                                    )
                                case "Passwords": PasswordsView()
                                case "Photos": PhotosView()
                                case "Reminders": RemindersView()
                                case "Safari": SafariView()
                                case "Shortcuts": ShortcutsView()
                                case "Stocks":
                                    ControllerBridgeView(
                                        "StocksSettings",
                                        controller: "SUStocksSettingsController",
                                        title: "Stocks"
                                    )
                                case "Translate": TranslateView()
                                case "TV":
                                    ControllerBridgeView(
                                        "TVSettings",
                                        controller: "TopLevelSettingsController",
                                        title: "TV"
                                    )
                                case "Voice Memos":
                                    ControllerBridgeView(
                                        "VoiceMemosSettings",
                                        controller: "RCVoiceMemosSettingsController",
                                        title: "Voice Memos"
                                    )
                                case "Weather":
                                    ControllerBridgeView(
                                        "WeatherSettings",
                                        controller: "WSWeatherSettingsController",
                                        title: "Weather"
                                    )
                                default: EmptyView()
                                }
                            }
                        }
                    }
                    .sectionIndexLabel(key)
                }
            }

            
            // MARK: Hidden Apps
            if searchText.isEmpty {
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
        }
        .searchable(
            text: $searchText,
            placement: UIDevice.iPhone ? .automatic : .toolbar,
            prompt: "Search Apps".localized(path: path)
        )
        .scrollIndicators(.hidden)
    }
}

struct AppInfo {
    let id = UUID()
    let name: String
    let icon: String
    let showOnSimulator: Bool
}

#Preview {
    NavigationStack {
        AppsView()
    }
}
