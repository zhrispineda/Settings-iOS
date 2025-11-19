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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(PrimarySettingsListModel.shared)
        }
        .commands {
            CommandGroup(replacing: .appSettings) {
                Button("About This iPad", systemImage: "ipad") {}
                if UIDevice.`apple-internal-install` {
                    Button("Debug Menu") {
                        PrimarySettingsListModel.shared.showingDebugMenu.toggle()
                    }.keyboardShortcut("/")
                }
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                handleSceneDidEnterBackground()
            }
        }
    }
    
    private func handleSceneDidEnterBackground() {
        var items: [UIApplicationShortcutItem] = [
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
            )
        ]
        
        if UIDevice.CellularTelephonyCapability {
            items.append(
                UIApplicationShortcutItem(
                    type: "com.example.Preferences.cellularData",
                    localizedTitle: "Cellular",
                    localizedSubtitle: nil,
                    icon: UIApplicationShortcutIcon(systemImageName: "antenna.radiowaves.left.and.right")
                )
            )
        }

        items.append(
            UIApplicationShortcutItem(
                type: "com.example.Preferences.power",
                localizedTitle: "Battery",
                localizedSubtitle: nil,
                icon: UIApplicationShortcutIcon(systemImageName: "battery.100")
            )
        )

        UIApplication.shared.shortcutItems = items
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
        let model = PrimarySettingsListModel.shared
        
        switch shortcutItem.type {
        case "com.example.Preferences.bluetooth":
            model.selection = model.radioSettings[3]
        case "com.example.Preferences.wifi":
            model.selection = model.radioSettings[1]
        case "com.example.Preferences.cellularData":
            model.selection = model.radioSettings[4]
        default:
            model.selection = model.radioSettings[6]
        }
    }
}
