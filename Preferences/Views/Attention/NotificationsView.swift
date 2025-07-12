//
//  NotificationsView.swift
//  Preferences
//
//  Settings > Notifications
//

import SwiftUI

struct NotificationsView: View {
    // Variables
    @AppStorage("NotificationPreviewOption") private var previewSelection: String = "SHOW_PREVIEW_OPTION_UNLOCKED"
    @AppStorage("AllowNotificationsScreenSharing") private var allowNotifications = false
    @State private var notificationStyle: NotificationStyle = .stack
    @State private var amberAlertsEnabled = true
    @State private var publicSafetyAlertsEnabled = true
    @State private var testAlertsEnabled = false
    let path = "/System/Library/PreferenceBundles/NotificationsSettings.bundle"
    let table = "NotificationsSettings"
    
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
                    
                    Button {
                        withAnimation {
                            notificationStyle = .count
                        }
                    } label: {
                        VStack(spacing: 10) {
                            Image(UIDevice.iPad ? "ipad-count" : UIDevice.HomeButtonCapability ? "iphone-D20-count" : "iphone-D7x-count")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 75)
                                .foregroundStyle(notificationStyle == .count ? .blue : .secondary)
                            ZStack {
                                RoundedRectangle(cornerRadius: 50.0)
                                    .frame(width: 50, height: 20)
                                    .foregroundStyle(notificationStyle == .count ? .blue : .clear)
                                Text("NOTIFICATION_LIST_DISPLAY_STYLE_COUNT".localized(path: path, table: table))
                                    .font(.caption)
                                    .foregroundStyle(notificationStyle == .count ? Color(UIColor.systemBackground) : .primary)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    Spacer()
                    
                    Button {
                        withAnimation {
                            notificationStyle = .stack
                        }
                    } label: {
                        VStack(spacing: 10) {
                            Image(UIDevice.iPad ? "ipad-stack" : UIDevice.HomeButtonCapability ? "iphone-D20-stack" : "iphone-D7x-stack")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 75)
                                .foregroundStyle(notificationStyle == .stack ? .blue : .secondary)
                            ZStack {
                                RoundedRectangle(cornerRadius: 50.0)
                                    .frame(width: 50, height: 20)
                                    .foregroundStyle(notificationStyle == .stack ? .blue : .clear)
                                Text("NOTIFICATION_LIST_DISPLAY_STYLE_STACK".localized(path: path, table: table))
                                    .font(.caption)
                                    .foregroundStyle(notificationStyle == .stack ? Color(UIColor.systemBackground) : .primary)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    Spacer()
                    
                    Button {
                        withAnimation {
                            notificationStyle = .list
                        }
                    } label: {
                        VStack(spacing: 10) {
                            Image(UIDevice.iPad ? "ipad-list" : UIDevice.HomeButtonCapability ? "iphone-D20-list" : "iphone-D7x-list")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 75)
                                .foregroundStyle(notificationStyle == .list ? .blue : .secondary)
                            ZStack {
                                RoundedRectangle(cornerRadius: 50.0)
                                    .frame(width: 50, height: 20)
                                    .foregroundStyle(notificationStyle == .list ? .blue : .clear)
                                Text("NOTIFICATION_LIST_DISPLAY_STYLE_LIST".localized(path: path, table: table))
                                    .font(.caption)
                                    .foregroundStyle(notificationStyle == .list ? Color(UIColor.systemBackground) : .primary)
                            }
                        }
                    }
                    .buttonStyle(.plain)
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
                SettingsLink("SHOW_PREVIEWS".localized(path: path, table: table), status: previewSelection.localized(path: path, table: table), destination: SelectOptionList("SHOW_PREVIEWS", options: ["SHOW_PREVIEW_OPTION_ALWAYS", "SHOW_PREVIEW_OPTION_UNLOCKED", "SHOW_PREVIEW_OPTION_NEVER"], selectedBinding: $previewSelection, selected: "SHOW_PREVIEW_OPTION_UNLOCKED", table: table))
                SettingsLink("SCREEN_SHARING".localized(path: path, table: table), status: (allowNotifications ? "SCREEN_SHARING_NOTIFICATIONS_ON" : "SCREEN_SHARING_NOTIFICATIONS_OFF").localized(path: path, table: table), destination: ScreenSharingView(allowNotifications: $allowNotifications))
                if UIDevice.IntelligenceCapability {
                    SettingsLink("SUMMARIZE_NOTIFICATIONS".localized(path: path, table: table), status: "OFF".localized(path: path, table: table), destination: SummarizeNotificationsView())
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
                SLink("Photos", icon: "applePhotos", subtitle: "Banners, Sounds, Badges") {}
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
