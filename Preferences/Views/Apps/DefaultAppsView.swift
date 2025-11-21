//
//  DefaultAppsView.swift
//  Preferences
//
//  Settings > Apps > Default Apps
//

import SwiftUI

struct DefaultAppsView: View {
    @State private var frameY = Double()
    @State private var opacity = Double()
    let path = "/System/Library/PrivateFrameworks/DefaultAppsSettingsUI.framework"
    
    var body: some View {
        CustomList(title: "Default Apps".localized(path: path)) {
            Placard(
                title: "Default Apps".localized(path: path),
                icon: "com.apple.graphic-icon.default-apps",
                description: "Placard Subtitle".localized(path: path),
                frameY: $frameY,
                opacity: $opacity
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
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Default Apps".localized(path: path))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DefaultAppsView()
    }
}
