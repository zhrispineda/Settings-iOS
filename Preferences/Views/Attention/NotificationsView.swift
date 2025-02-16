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
    let table = "NotificationsSettings"
    
    enum NotificationStyle {
        case count
        case stack
        case list
    }
    
    var body: some View {
        CustomList(title: "TITLE".localize(table: table), topPadding: true) {
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
                                Text("NOTIFICATION_LIST_DISPLAY_STYLE_COUNT", tableName: table)
                                    .font(.caption)
                                    .foregroundStyle(notificationStyle == .count ? Color(UIColor.systemBackground) : Color["Label"])
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
                                Text("NOTIFICATION_LIST_DISPLAY_STYLE_STACK", tableName: table)
                                    .font(.caption)
                                    .foregroundStyle(notificationStyle == .stack ? Color(UIColor.systemBackground) : Color["Label"])
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
                                Text("NOTIFICATION_LIST_DISPLAY_STYLE_LIST", tableName: table)
                                    .font(.caption)
                                    .foregroundStyle(notificationStyle == .list ? Color(UIColor.systemBackground) : Color["Label"])
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
            } header: {
                Text("NOTIFICATION_LIST_DISPLAY_STYLE_TITLE", tableName: table)
            } footer: {
                Text("NOTIFICATION_LIST_DISPLAY_STYLE_FOOTER", tableName: table)
            }
            
            // MARK: Notification Options Section
            Section {
                CustomNavigationLink(title: "NOTIFICATION_DELIVERY_SCHEDULED".localize(table: table), status: "OFF".localize(table: table), destination: ScheduledSummaryView())
                CustomNavigationLink(title: "SHOW_PREVIEWS".localize(table: table), status: previewSelection.localize(table: table), destination: SelectOptionList(title: "SHOW_PREVIEWS", options: ["SHOW_PREVIEW_OPTION_ALWAYS", "SHOW_PREVIEW_OPTION_UNLOCKED", "SHOW_PREVIEW_OPTION_NEVER"], selectedBinding: $previewSelection, selected: "SHOW_PREVIEW_OPTION_UNLOCKED", table: table))
                CustomNavigationLink(title: "SCREEN_SHARING".localize(table: table), status: (allowNotifications ? "SCREEN_SHARING_NOTIFICATIONS_ON" : "SCREEN_SHARING_NOTIFICATIONS_OFF").localize(table: table), destination: ScreenSharingView(allowNotifications: $allowNotifications))
                CustomNavigationLink(title: "SUMMARIZE_NOTIFICATIONS".localize(table: table), status: "OFF".localize(table: table), destination: EmptyView())
            }
            
            // MARK: Siri Section
            Section {
                CustomNavigationLink(title: "SPOKEN_NOTIFICATIONS".localize(table: table), status: "OFF".localize(table: table), destination: EmptyView())
                NavigationLink("SIRI_SUGGESTIONS".localize(table: table)) {}
            } header: {
                Text("SIRI", tableName: table)
            }
            
            // MARK: App Notifications Section
            Section {
                SettingsLink(icon: "applePhotos", id: "Photos", subtitle: "Banners, Sounds, Badges") {}
            } header: {
                Text("NOTIFICATION_STYLE", tableName: table)
            }
            
            // MARK: Government Alerts Section
            if UIDevice.iPhone {
                Section {
                    Toggle("AMBER Alerts", isOn: $amberAlertsEnabled)
                    CustomNavigationLink(title: "Emergency Alerts", status: "On", destination: EmptyView())
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
