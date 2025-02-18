//
//  AnnounceNotificationsView.swift
//  Preferences
//
//  Settings > Notifications > Announce Notifications
//

import SwiftUI

struct AnnounceNotificationsView: View {
    // Variables
    @AppStorage("AnnounceNotificationsToggle") private var announceNotifications = false
    let table = "NotificationsSettings"
    
    var body: some View {
        CustomList(title: "SPOKEN_NOTIFICATIONS".localize(table: table)) {
            Section {
                Toggle("SPOKEN_NOTIFICATIONS".localize(table: table), isOn: .constant(false))
            } footer: {
                Text("SPOKEN_NOTIFICATIONS_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AnnounceNotificationsView()
    }
}
