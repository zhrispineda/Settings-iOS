//
//  NotificationsView.swift
//  Preferences
//

import SwiftUI

/// The view for Settings > Notifications.
struct NotificationsView: View {
    @AppStorage("AlertToggleStates") private var alertToggleStates: String = "{}"
    @AppStorage("NotificationPreviewOption") private var previewSelection = "SHOW_PREVIEW_OPTION_UNLOCKED"
    @AppStorage("AllowNotificationsScreenSharing") private var allowNotifications = false
    @State private var alertCells: [AlertItem] = []
    @State private var alertStates: [String: Bool] = [:]
    @State private var notificationStyle: NotificationStyle = .stack
    private let extensionPath = "/System/Library/ExtensionKit/Extensions/NotificationsSettingsExtension.appex"
    private let path = "/System/Library/PreferenceBundles/NotificationsSettings.bundle"
    private let table = "NotificationsSettings"
    private var deviceType: String {
        if UIDevice.iPad {
            return "ipad"
        }
        return UIDevice.HomeButtonCapability ? "iphone-D20" : "iphone-D7x"
    }
    private var variantType: String {
        return UIDevice.iPad && UIDevice.HomeButtonCapability ? "-legacy" : ""
    }
    private var countImage: String { "\(deviceType)-count\(variantType)" }
    private var stackImage: String { "\(deviceType)-stack\(variantType)" }
    private var listImage: String { "\(deviceType)-list\(variantType)" }
    
    private enum NotificationStyle {
        case count
        case stack
        case list
    }
    
    var body: some View {
        CustomList(title: "TITLE".localized(path: path, table: table), topPadding: true) {
            // MARK: Display As Section
            Section {
                HStack {
                    Spacer()
                    if let displayIcon = UIImage.asset(path: path, name: countImage) {
                        NotificationStyleButton(
                            icon: displayIcon,
                            label: "NOTIFICATION_LIST_DISPLAY_STYLE_COUNT".localized(path: path, table: table),
                            isSelected: notificationStyle == .count
                        ) {
                            withAnimation {
                                notificationStyle = .count
                            }
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    
                    if let displayIcon = UIImage.asset(path: path, name: stackImage) {
                        NotificationStyleButton(
                            icon: displayIcon,
                            label: "NOTIFICATION_LIST_DISPLAY_STYLE_STACK".localized(path: path, table: table),
                            isSelected: notificationStyle == .stack
                        ) {
                            withAnimation {
                                notificationStyle = .stack
                            }
                        }
                    }
                    
                    Spacer()
                    Spacer()
                    
                    if let displayIcon = UIImage.asset(path: path, name: listImage) {
                        NotificationStyleButton(
                            icon: displayIcon,
                            label: "NOTIFICATION_LIST_DISPLAY_STYLE_LIST".localized(path: path, table: table),
                            isSelected: notificationStyle == .list
                        ) {
                            withAnimation {
                                notificationStyle = .list
                            }
                        }
                    }
                    Spacer()
                }
            } header: {
                Text("NOTIFICATION_LIST_DISPLAY_STYLE_TITLE".localized(path: path, table: table))
            } footer: {
                Text("NOTIFICATION_LIST_DISPLAY_STYLE_FOOTER".localized(path: path, table: table))
            }
            
            // MARK: Notification Options Section
            Section {
                SettingsLink(
                    "NOTIFICATION_DELIVERY_SCHEDULED".localized(path: path, table: table),
                    status: "OFF".localized(path: path, table: table),
                    destination: ScheduledSummaryView()
                )
                SettingsLink(
                    "SHOW_PREVIEWS".localized(path: path, table: table),
                    status: previewSelection.localized(path: path, table: table),
                    destination: SelectOptionList(
                        "SHOW_PREVIEWS",
                        options: ["SHOW_PREVIEW_OPTION_ALWAYS", "SHOW_PREVIEW_OPTION_UNLOCKED", "SHOW_PREVIEW_OPTION_NEVER"],
                        selected: $previewSelection,
                        path: path,
                        table: table
                    )
                )
                SettingsLink(
                    "SCREEN_SHARING".localized(path: path, table: table),
                    status: (allowNotifications
                             ? "SCREEN_SHARING_NOTIFICATIONS_ON"
                             : "SCREEN_SHARING_NOTIFICATIONS_OFF").localized(path: path, table: table),
                    destination: ScreenSharingView(allowNotifications: $allowNotifications)
                )
            }
            
            if UIDevice.IntelligenceCapability {
                Section {
                    SettingsLink(
                        "PRIORITIZE_NOTIFICATIONS".localized(path: path, table: table),
                        status: "OFF".localized(path: path, table: table)
                    ) {
                        ControllerBridgeView(
                            "/System/Library/PreferenceBundles/NotificationsSettings.bundle/NotificationsSettings",
                            controller: "NCPriorityNotificationsDetailController",
                            title: "PRIORITIZE_NOTIFICATIONS".localized(path: path, table: table)
                        )
                    }
                    SettingsLink(
                        "SUMMARIZE_NOTIFICATIONS".localized(path: path, table: table),
                        status: "OFF".localized(path: path, table: table),
                        destination: ControllerBridgeView(
                            "NotificationsSettings",
                            controller: "NCSummarizePreviewsDetailController",
                            title: "SUMMARIZE_NOTIFICATIONS".localized(path: path, table: table)
                        )
                    )
                } header: {
                    Text("APPLE_INTELLIGENCE".localized(path: path, table: table))
                } footer: {
                    Text("APPLE_INTELLIGENCE_FOOTER".localized(path: path, table: table))
                }
            }
            
            // MARK: Siri Section
            Section {
                SettingsLink(
                    "SPOKEN_NOTIFICATIONS".localized(path: path, table: table),
                    status: "OFF".localized(path: path, table: table),
                    destination: AnnounceNotificationsView()
                )
                NavigationLink(
                    "SIRI_SUGGESTIONS".localized(path: path, table: table),
                    destination: SiriSuggestionsView()
                )
            } header: {
                Text("SIRI".localized(path: path, table: table))
            }
            
            // MARK: App Notifications Section
            Section {
                SLink("Photos", icon: "com.apple.mobileslideshow", subtitle: "Banners, Sounds, Badges") {}
            } header: {
                Text("NOTIFICATION_STYLE".localized(path: path, table: table))
            }
            
            // MARK: Government Alerts Section
            if UIDevice.iPhone {
                Section("Government Alerts".localized(path: extensionPath)) {
                    ForEach(alertCells) { alert in
                        let binding = Binding(
                            get: { alertStates[alert.id] ?? false },
                            set: {
                                alertStates[alert.id] = $0
                                saveAlertStates()
                            }
                        )

                        if alert.hasNavigation {
                            NavigationLink(
                                destination: AlertsDetailView(
                                    label: alert.name.localized(path: extensionPath),
                                    isOn: binding
                                )
                            ) {
                                LabeledContent(alert.name.localized(path: extensionPath),
                                               value: binding.wrappedValue ? "On" : "Off")
                            }
                        } else {
                            Toggle(alert.name, isOn: binding)
                        }
                    }
                }
            }
        }
        .task {
            loadAlertStates()
            if alertCells.isEmpty {
                setupAlertsLayout()
            }
        }
    }
    
    /// Sets up the layout for `Government Alerts` section.
    ///
    /// - Note: This section will be empty in Simulator and Previews.
    ///
    /// This function reads `carrier.plist` and its `AlertTypes` dictionary.
    /// It then sets up each item as an `AlertItem` to display as either a toggle or navigation link.
    private func setupAlertsLayout() {
        guard let code = Locale.current.region?.identifier else { return }
        
        let name = Locale(identifier: "en_US").localizedString(forRegionCode: code)
        
        let country = name?
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .map { $0.capitalized }
            .joined()
        
        let fileURL = URL(fileURLWithPath: "/System/Library/CountryBundles/iPhone/\(country ?? "Unknown").bundle/carrier.plist")
        
        if NSDictionary(contentsOf: fileURL) is [String: Any] {
            SettingsLogger.info("Found carrier information. Setting up layout…")
            guard
                let data = try? Data(contentsOf: fileURL),
                let plist = try? PropertyListSerialization.propertyList(from: data, format: nil),
                let root = plist as? [String: Any],
                let cell = root["CellBroadcast"] as? [String: Any],
                let alertTypes = cell["AlertTypes"] as? [String: Any]
            else { return }

            let parsed = alertTypes.compactMap { key, value -> AlertItem? in
                guard let dict = value as? [String: Any] else { return nil }
                return AlertItem(id: key, dict: dict)
            }
            .filter { $0.isVisible }
            .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }

            alertCells = parsed

            for alert in parsed where alertStates[alert.id] == nil {
                alertStates[alert.id] = alert.enabled
            }

            saveAlertStates()
        } else {
            SettingsLogger.error("Could not get carrier information: \(fileURL)")
        }
    }
    
    private func loadAlertStates() {
        if let data = alertToggleStates.data(using: .utf8),
           let decoded = try? JSONDecoder().decode([String: Bool].self, from: data) {
            alertStates = decoded
        }
    }
    
    private func saveAlertStates() {
        if let data = try? JSONEncoder().encode(alertStates),
           let json = String(data: data, encoding: .utf8) {
            alertToggleStates = json
        }
    }
}

/// The view for Settings > Notifications > Emergency Alerts
private struct AlertsDetailView: View {
    @AppStorage("LocalAwarenessToggle") private var localAwareness = true
    @AppStorage("AlwaysPlaySoundToggle") private var alwaysPlaySound = false
    let label: String
    @Binding var isOn: Bool
    private let path = "/System/Library/PreferenceBundles/EmergencyAlertExtension.bundle"
    private let table = "Localizable~IGNEOUS"

    var body: some View {
        CustomList(title: label) {
            Section {
                Toggle(label, isOn: $isOn)
            }
            
            if isOn {
                Section {
                    Toggle("ENHANCED_DELIVERY_SWITCH_NAME".localized(path: path, table: table), isOn: $localAwareness)
                } footer: {
                    Text("ENHANCED_DELIVERY_DESCRIPTION".localized(path: path, table: table))
                }
                
                Section {
                    Toggle("ALWAYS_DELIVER".localized(path: path), isOn: $alwaysPlaySound)
                } footer: {
                    Text("ALWAYS_DELIVER_MESSAGE".localized(path: path))
                }
            }
        }
    }
}

/// A device style button for displaying notifications. Displays a device frame with text below.
private struct NotificationStyleButton: View {
    let icon: UIImage
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                ZStack {
                    Image(uiImage: icon)
                        .renderingMode(.template)
                        .foregroundStyle(isSelected ? .blue : .secondary)
                    Text("9:41")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(isSelected ? .blue : .primary.opacity(0.5))
                        .offset(y: UIDevice.iPhone ? -20 : -25)
                        .kerning(-1.0)
                }
                Text(label)
                    .font(.caption)
                    .foregroundStyle(isSelected ? Color(UIColor.systemBackground) : .primary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(isSelected ? .blue : .clear)
                    }
            }
        }
        .buttonStyle(.plain)
    }
}

/// The structure for `carrier.plist` items used to set up its section layout.
///
/// - Parameter id: The name of the `AlertTypes` dictionary.
/// - Parameter dict: The `String` dictionary containing all alert item specifiers.
///
/// These constants are initialized from the dictionary item itself:
/// - enabled: The `EnabledByDefault` value for whether the cell is enabled by default.
/// - isVisible: The `UserConfigurable` value for whether the cell is visible and configurable by the user.
/// - hasNavigation: The `CustomPreferences` value for whether the cell is a navigation link.
private struct AlertItem: Identifiable {
    let id: String
    let name: String
    let enabled: Bool
    let isVisible: Bool
    let hasNavigation: Bool

    init(id: String, dict: [String: Any]) {
        self.id = id
        self.name = dict["SwitchName"] as? String ?? id
        self.enabled = dict["EnabledByDefault"] as? Bool ?? false
        self.isVisible = dict["UserConfigurable"] as? Bool ?? false
        self.hasNavigation = dict["CustomPreferences"] != nil
    }
}

#Preview {
    NavigationStack {
        NotificationsView()
    }
}

#Preview("Emergency Alerts") {
    @Previewable @State var enabled = true
    
    NavigationStack {
        AlertsDetailView(label: "Emergency Alerts", isOn: $enabled)
    }
}
