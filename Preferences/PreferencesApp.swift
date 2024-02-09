//
//  PreferencesApp.swift
//  Preferences
//
//  Settings
//

import SwiftUI

@main
struct PreferencesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DeviceInfo())
        }
    }
}
