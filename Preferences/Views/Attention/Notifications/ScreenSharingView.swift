//
//  ScreenSharingView.swift
//  Preferences
//
//  Settings > Notifications > Screen Sharing
//

import SwiftUI

struct ScreenSharingView: View {
    // Variables
    @Binding var allowNotifications: Bool
    let table = "NotificationsSettings"
    
    var body: some View {
        CustomList(title: "SCREEN_SHARING".localize(table: table)) {
            Section {
                Toggle("ALLOW_NOTIFICATIONS".localize(table: table), isOn: $allowNotifications)
            } footer: {
                Text("SCREEN_SHARING_ALLOW_NOTIFICATIONS_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScreenSharingView(allowNotifications: .constant(false))
    }
}
