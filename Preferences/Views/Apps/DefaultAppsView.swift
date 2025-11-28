//
//  DefaultAppsView.swift
//  Preferences
//

import SwiftUI

//  Settings > Apps > Default Apps
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
                SettingsLink("Email".localized(path: path), status: "None".localized(path: path)) {}
                if !UIDevice.IsSimulator {
                    SettingsLink("Messaging".localized(path: path), status: "Messages") {}
                }
                SettingsLink("Calling".localized(path: path), status: "None".localized(path: path)) {}
                if !UIDevice.IsSimulator {
                    SettingsLink("Call Filtering".localized(path: path), status: "None".localized(path: path)) {}
                }
            }
            
            Section {
                if UIDevice.IsSimulator {
                    SettingsLink("Navigation", status: "Maps") {}
                }
                SettingsLink("Browser App".localized(path: path), status: "Safari") {}
                SettingsLink("Translation", status: "None".localized(path: path)) {}
                if !UIDevice.IsSimulator {
                    SettingsLink("Passwords & Codes", status: "Passwords".localized(path: path)) {}
                    SettingsLink("Contactless App", status: "Wallet".localized(path: path)) {}
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
