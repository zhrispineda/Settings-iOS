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
    
    case multitaskGestures = "Multitasking & Gestures"
    case accessibility = "Accessibility"
    case general = "General"
    case privacySecurity = "Privacy & Security"
    
    case passwords = "Passwords"
    
    case safari = "Safari"
    case news = "News"
    case translate = "Translate"
    case maps = "Maps"
    case shortcuts = "Shortcuts"
    case health = "Health"
    case siriSearch = "Siri & Search"
    case photos = "Photos"
    case gameCenter = "Game Center"
}

struct SettingsItem<Content: View>: Identifiable {
    var id: String { title }
    let type: SettingsModel
    let title: String
    let icon: String
    var color: Color = Color(.gray)
    let destination: Content
}

let smallerIcons = ["squares.leading.rectangle", "key.fill"]

// Attention Settings: Screen Time
let attentionSettings: [SettingsItem] = [
    SettingsItem(type: .screenTime, title: "Screen Time", icon: "hourglass", color: .indigo, destination: AnyView(ScreenTimeView())),
]

// Main Settings: General
let mainSettings: [SettingsItem] = [
    SettingsItem(type: .general, title: "General", icon: "gear", color: .gray, destination: AnyView(GeneralView())),
    SettingsItem(type: .multitaskGestures, title: "Multitasking & Gestures", icon: "squares.leading.rectangle", color: .blue, destination: AnyView(EmptyView())),
    SettingsItem(type: .accessibility, title: "Accessibility", icon: "accessibility", color: .blue, destination: AnyView(EmptyView())),
    SettingsItem(type: .privacySecurity, title: "Privacy & Security", icon: "hand.raised.fill", color: .blue, destination: AnyView(EmptyView()))
]

// Services Settings: Passwords
let servicesSettings: [SettingsItem] = [
    SettingsItem(type: .passwords, title: "Passwords", icon: "key.fill", color: .gray, destination: AnyView(EmptyView()))
]

// Apps Settings: Safari
let appsSettings: [SettingsItem] = [
    SettingsItem(type: .safari, title: "Safari", icon: "applesafari", destination: AnyView(EmptyView())),
    SettingsItem(type: .news, title: "News", icon: "applenews", destination: AnyView(EmptyView())),
    SettingsItem(type: .translate, title: "Translate", icon: "Icon", color: .white, destination: AnyView(EmptyView())),
    SettingsItem(type: .maps, title: "Maps", icon: "applemaps", destination: AnyView(EmptyView())),
    SettingsItem(type: .shortcuts, title: "Shortcuts", icon: "appleshortcuts", destination: AnyView(EmptyView())),
    SettingsItem(type: .health, title: "Health", icon: "applehealth", destination: AnyView(EmptyView())),
    SettingsItem(type: .siriSearch, title: "Siri & Search", icon: "applesiri", color: Color(UIColor.systemBackground), destination: AnyView(EmptyView())),
    SettingsItem(type: .photos, title: "Photos", icon: "applephotos", destination: AnyView(EmptyView())),
    SettingsItem(type: .gameCenter, title: "Game Center", icon: "applegamecenter", destination: AnyView(EmptyView()))
]

// Combined Settings Array
let combinedSettings = attentionSettings + mainSettings + servicesSettings + appsSettings
