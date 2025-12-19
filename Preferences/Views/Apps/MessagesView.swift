//
//  MessagesView.swift
//  Preferences
//
//  Settings > Apps > Messages
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        ControllerBridgeView(
            "/System/Library/PrivateFrameworks/CommunicationsSetupUI.framework/CommunicationsSetupUI",
            controller: "CNFRegAppleIDSplashViewController",
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
