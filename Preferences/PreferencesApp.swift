//
//  PreferencesApp.swift
//  Preferences
//
//  Settings
//

import SwiftUI

@main
struct PreferencesApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @State private var stateManager = StateManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(stateManager)
        }
        .commands {
            CommandGroup(replacing: .appSettings) {
                Button("About This iPad", systemImage: "ipad") {}
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                quickActionShortcutItems()
            }
        }
    }
    
    private func quickActionShortcutItems() {
        UIApplication.shared.shortcutItems = [
            UIApplicationShortcutItem(
                type: "com.example.Preferences.bluetooth",
                localizedTitle: "Bluetooth",
                localizedSubtitle: nil,
                icon: UIApplicationShortcutIconHelper.icon(withSystemImageName: "bluetooth")
            ),
            UIApplicationShortcutItem(
                type: "com.example.Preferences.wifi",
                localizedTitle: "Wi-Fi",
                localizedSubtitle: nil,
                icon: UIApplicationShortcutIcon(systemImageName: "wifi")
            ),
            UIApplicationShortcutItem(
                type: "com.example.Preferences.cellularData",
                localizedTitle: "Cellular",
                localizedSubtitle: nil,
                icon: UIApplicationShortcutIcon(systemImageName: "antenna.radiowaves.left.and.right")
            ),
            UIApplicationShortcutItem(
                type: "com.example.Preferences.power",
                localizedTitle: "Battery",
                localizedSubtitle: nil,
                icon: UIApplicationShortcutIcon(systemImageName: "battery.100")
            )
        ]
    }
}
