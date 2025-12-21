//
//  DefaultAppsView.swift
//  Preferences
//

import SwiftUI

/// Settings > Apps > Default Apps
struct DefaultAppsView: View {
    @State private var titleVisible = false
    let path = "/System/Library/PrivateFrameworks/DefaultAppsSettingsUI.framework"
    
    var body: some View {
        CustomList(title: titleVisible ? "Default Apps".localized(path: path) : "") {
            Placard(
                title: "Default Apps".localized(path: path),
                icon: "com.apple.graphic-icon.default-apps",
                description: "Placard Subtitle".localized(path: path),
                isVisible: $titleVisible
            )
            
            Section {
                SLink("Email".localized(path: path), status: "None".localized(path: path)) {}
                if !UIDevice.IsSimulator {
                    SLink("Messaging".localized(path: path), status: "Messages") {}
                }
                SLink("Calling".localized(path: path), status: "None".localized(path: path)) {}
                if !UIDevice.IsSimulator {
                    SLink("Call Filtering".localized(path: path), status: "None".localized(path: path)) {
                        ControllerBridgeView(
                            "/System/Library/PrivateFrameworks/TelephonyPreferences.framework/TelephonyPreferences",
                            controller: "DefaultSpamFilterListController",
                            title: "Call Filtering".localized(path: path)
                        )
                    }
                }
            }
            
            Section {
                if UIDevice.IsSimulator {
                    SLink("Navigation", status: "Maps") {}
                }
                SLink("Browser App".localized(path: path), status: "Safari") {}
                SLink("Translation", status: "None".localized(path: path)) {}
                if !UIDevice.IsSimulator {
                    SLink("Passwords & Codes", status: "Passwords".localized(path: path)) {}
                    if UIDevice.iPhone {
                        SLink("Contactless App", status: "Wallet".localized(path: path)) {}
                    }
                }
                SLink("Keyboards", status: "2".localized(path: path)) {
                    ControllerBridgeView(
                        "KeyboardSettings",
                        controller: "TIKeyboardListController",
                        title: "Keyboards".localized(path: path)
                    )
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DefaultAppsView()
    }
}
