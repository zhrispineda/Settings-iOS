//
//  ScreenSharingView.swift
//  Preferences
//
//  Settings > Notifications > Screen Sharing
//

import SwiftUI

struct ScreenSharingView: View {
    @Binding var allowNotifications: Bool
    let path = "/System/Library/PreferenceBundles/NotificationsSettings.bundle"
    let table = "NotificationsSettings"
    
    var body: some View {
        CustomList(title: "SCREEN_SHARING".localized(path: path, table: table)) {
            Section {
                Toggle("ALLOW_NOTIFICATIONS".localized(path: path, table: table), isOn: $allowNotifications)
            } footer: {
                Text("SCREEN_SHARING_ALLOW_NOTIFICATIONS_FOOTER".localized(path: path, table: table))
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScreenSharingView(allowNotifications: .constant(false))
    }
}
