//
//  ContactsView.swift
//  Preferences
//
//  Settings > Apps > Contacts
//

import SwiftUI

/// A bridge for the settings controller from Contacts.
/// - Warning: This view may freeze in Xcode Previews, especially after scrolling down because the app cannot prompt for contacts permission.
///
/// **Workaround:** Use the app in Simulator or a physical device.
struct ContactsView: View {
    var body: some View {
        ControllerBridgeView(
            "ContactsSettings",
            controller: "ContactsSettingsPlugin",
            title: "CONTACTS".localized(
                path: "/System/Library/PreferenceBundles/ContactsSettings.bundle",
                table: "Contacts"
            )
        )
    }
}

#Preview {
    NavigationStack {
        ContactsView()
    }
}
