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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    private let stateManager = StateManager.shared

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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        handleShortcutItem(shortcutItem)
        completionHandler(true)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let shortcutItem = connectionOptions.shortcutItem {
            handleShortcutItem(shortcutItem)
        }
    }

    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem) {
        let stateManager = StateManager.shared
        switch shortcutItem.type {
        case "com.example.Preferences.bluetooth":
            stateManager.selection = stateManager.radioSettings[3]
        case "com.example.Preferences.wifi":
            stateManager.selection = stateManager.radioSettings[1]
        case "com.example.Preferences.cellularData":
            stateManager.selection = stateManager.radioSettings[4]
        default:
            stateManager.selection = stateManager.radioSettings[6]
        }
    }
}
