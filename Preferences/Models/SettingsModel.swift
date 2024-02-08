//
//  SettingsModel.swift
//  Preferences
//
//  Settings
//

import SwiftUI

class DeviceInfo: ObservableObject {
    @Published var model: String = UIDevice.current.localizedModel
    
    var isPhone = UIDevice.current.localizedModel == "iPhone"
}

enum SettingsModel: String, CaseIterable {
    case screenTime = "Screen Time"
    case general = "General"
}

struct SettingsItem<Content: View>: Identifiable {
    var id: String { title }
    let type: SettingsModel
    let title: String
    let icon: String
    var color: Color = Color(.gray)
    let destination: Content
}

// Focus Settings: Screen Time
let focusSettings: [SettingsItem] = [
    SettingsItem(type: .screenTime, title: "Screen Time", icon: "hourglass", color: .indigo, destination: AnyView(ScreenTimeView())),
]

// Main Settings: General
let mainSettings: [SettingsItem] = [
    SettingsItem(type: .general, title: "General", icon: "gear", color: .gray, destination: AnyView(GeneralView())),
]

// Combined Settings Array
let combinedSettings = focusSettings + mainSettings
