//
//  PreferencesApp.swift
//  Preferences
//
//  Settings
//

import SwiftUI

@main
struct PreferencesApp: App {
    @State private var stateManager = StateManager()

    var body: some Scene {
        WindowGroup {
            ContentView(stateManager: stateManager)
                .environment(stateManager)
        }
        .commands {
            CommandGroup(replacing: .appSettings) {
                Button("About This iPad", systemImage: "ipad") {}
            }
        }
    }
}
