//
//  NotificationsView.swift
//  Preferences
//
//  Settings > Notifications
//

import SwiftUI

struct NotificationStyleButton: View {
    let icon: UIImage
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(uiImage: icon)
                    .renderingMode(.template)
                    .foregroundStyle(isSelected ? .blue : .secondary)
                Text(label)
                    .font(.caption)
                    .foregroundStyle(isSelected ? Color(UIColor.systemBackground) : .primary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundStyle(isSelected ? .blue : .clear)
                    }
            }
        }
        .buttonStyle(.plain)
    }
}

struct NotificationsView: View {
    @AppStorage("NotificationPreviewOption") private var previewSelection = "SHOW_PREVIEW_OPTION_UNLOCKED"
    @AppStorage("AllowNotificationsScreenSharing") private var allowNotifications = false
    @State private var notificationStyle: NotificationStyle = .stack
    @State private var amberAlertsEnabled = true
    @State private var publicSafetyAlertsEnabled = true
    @State private var testAlertsEnabled = false
    let path = "/System/Library/PreferenceBundles/NotificationsSettings.bundle"
    let table = "NotificationsSettings"
    var countImage: String {
        return UIDevice.iPad ? "ipad-count" : UIDevice.HomeButtonCapability ? "iphone-D20-count" : "iphone-D7x-count"
    }
    var stackImage: String {
        return UIDevice.iPad ? "ipad-stack" : UIDevice.HomeButtonCapability ? "iphone-D20-stack" : "iphone-D7x-stack"
    }
    var listImage: String {
        return UIDevice.iPad ? "ipad-list" : UIDevice.HomeButtonCapability ? "iphone-D20-list" : "iphone-D7x-list"
    }
    
    enum NotificationStyle {
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
                            notificationStyle = .count
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
                            notificationStyle = .stack
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
                            notificationStyle = .list
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
                SettingsLink("NOTIFICATION_DELIVERY_SCHEDULED".localized(path: path, table: table), status: "OFF".localized(path: path, table: table), destination: ScheduledSummaryView())
                SettingsLink("SHOW_PREVIEWS".localized(path: path, table: table), status: previewSelection.localized(path: path, table: table), destination: SelectOptionList("SHOW_PREVIEWS", options: ["SHOW_PREVIEW_OPTION_ALWAYS", "SHOW_PREVIEW_OPTION_UNLOCKED", "SHOW_PREVIEW_OPTION_NEVER"], selected: $previewSelection, table: table))
                SettingsLink("SCREEN_SHARING".localized(path: path, table: table), status: (allowNotifications ? "SCREEN_SHARING_NOTIFICATIONS_ON" : "SCREEN_SHARING_NOTIFICATIONS_OFF").localized(path: path, table: table), destination: ScreenSharingView(allowNotifications: $allowNotifications))
            }
            
            if UIDevice.IntelligenceCapability {
                Section {
                    SettingsLink(
                        "PRIORITIZE_NOTIFICATIONS".localized(path: path, table: table),
                        status: "OFF".localized(path: path, table: table)
                    ) {
                        BundleControllerView(
                            "/System/Library/PreferenceBundles/NotificationsSettings.bundle/NotificationsSettings",
                            controller: "NCPriorityNotificationsDetailController",
                            title: "PRIORITIZE_NOTIFICATIONS".localized(path: path, table: table)
                        )
                    }
                    SettingsLink("SUMMARIZE_NOTIFICATIONS".localized(path: path, table: table), status: "OFF".localized(path: path, table: table), destination: SummarizeNotificationsView())
                } header: {
                    Text("APPLE_INTELLIGENCE".localized(path: path, table: table))
                } footer: {
                    Text("APPLE_INTELLIGENCE_FOOTER".localized(path: path, table: table))
                }
            }
            
            // MARK: Siri Section
            Section {
                SettingsLink("SPOKEN_NOTIFICATIONS".localized(path: path, table: table), status: "OFF".localized(path: path, table: table), destination: AnnounceNotificationsView())
                NavigationLink("SIRI_SUGGESTIONS".localized(path: path, table: table), destination: SiriSuggestionsView())
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
                Section {
                    Toggle("AMBER Alerts", isOn: $amberAlertsEnabled)
                    SettingsLink("Emergency Alerts", status: "On", destination: EmptyView())
                    Toggle("Public Safety Alerts", isOn: $publicSafetyAlertsEnabled)
                    Toggle("Test Alerts", isOn: $testAlertsEnabled)
                } header: {
                    Text("Government Alerts")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NotificationsView()
    }
}
