//
//  AnnounceNotificationsView.swift
//  Preferences
//
//  Settings > Notifications > Announce Notifications
//

import SwiftUI

struct AnnounceNotificationsView: View {
    @AppStorage("AnnounceNotificationsToggle") private var announceNotifications = false
    let path = "/System/Library/PreferenceBundles/NotificationsSettings.bundle"
    let table = "NotificationsSettings"
    
    var body: some View {
        CustomList(title: "SPOKEN_NOTIFICATIONS".localized(path: path, table: table)) {
            Section {
                Toggle("SPOKEN_NOTIFICATIONS".localized(path: path, table: table), isOn: .constant(false))
            } footer: {
                Text("SPOKEN_NOTIFICATIONS_FOOTER".localized(path: path, table: table))
            }
        }
    }
}

#Preview {
    NavigationStack {
        AnnounceNotificationsView()
    }
}
