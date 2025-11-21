//
//  MessagesView.swift
//  Preferences
//
//  Settings > Apps > Messages
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        BundleControllerView(
            "/System/Library/PrivateFrameworks/CommunicationsSetupUI.framework/CommunicationsSetupUI",
            controller: "CKSettingsMessagesController",
            title: "MESSAGES".localized(
                path: "/System/Library/PrivateFrameworks/MessagesSettingsUI.framework",
                table: "MessagesSettings"
            )
        )
    }
}

#Preview {
    NavigationStack {
        MessagesView()
    }
}
