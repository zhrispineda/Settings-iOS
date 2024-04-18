//
//  SettingsModel.swift
//  Preferences
//
//  Settings
//

import SwiftUI

// MARK: Global variables
struct Configuration {
    let isSimulator = false
}

// MARK: Color extension
extension Color {
    static subscript(name: String) -> Color {
        switch name {
        case "Label":
            return Color(UIColor.label)
        case "Default":
            return Color.accentColor
        case "Gray":
            return Color.gray
        case "White":
            return Color.white
        case "Blue":
            return Color.blue
        case "Red":
            return Color.red
        case "Green":
            return Color.green
        case "Yellow":
            return Color.yellow
        case "Orange":
            return Color.orange
        case "Pink":
            return Color.pink
        case "Purple":
            return Color.purple
        default:
            return Color.clear
        }
    }
}

// MARK: DeviceInfo class
class DeviceInfo: ObservableObject {
    @Published var model: String = UIDevice.current.localizedModel
    
    var isPhone = UIDevice.current.localizedModel == "iPhone"
    var isTablet = UIDevice.current.localizedModel == "iPad"
    var isPro = UIDevice.current.name.contains("Pro")
    var isLargestTablet = UIDevice.current.name.contains("12.9")
    var hasHomeButton = UIDevice.current.name.contains("SE")
    var hasFaceAuth = !UIDevice.current.name.contains("SE") && !UIDevice.current.name.contains("Air") && !UIDevice.current.name.contains("iPad (")
}


// MARK: SettingsModel data
enum SettingsModel: String, CaseIterable {
    case wifi = "Wi-Fi"
    case bluetooth = "Bluetooth"
    case cellular = "Cellular"
    case personalHotspot = "Personal Hotspot"
    
    case notifications = "Notifications"
    case soundHaptics = "Sound & Haptics"
    case focus = "Focus"
    case screenTime = "Screen Time"
    case actionButton = "Action Button"
    
    case general = "General"
    case controlCenter = "Control Center"
    case displayBrightness = "Display & Brightness"
    case homeScreenAppLibrary = "Home Screen & App Library"
    case multitaskGestures = "Multitasking & Gestures"
    case accessibility = "Accessibility"
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
    
    case developer = "Developer"
}

struct SettingsItem<Content: View>: Identifiable {
    var id: String { title }
    let type: SettingsModel
    let title: String
    let icon: String
    var color: Color = Color(.gray)
    let destination: Content
}

// MARK: SF Symbol names for smaller icons
let smallerIcons = ["airplane", "arrow.turn.up.forward.iphone", "personalhotspot", "speaker.3.fill", "moon.fill", "squares.leading.rectangle", "key.fill", "hammer.fill", "shareplay", "wifi"]

// Radio Settings: Wi-Fi, Bluetooth, Cellular, Personal Hotspot, VPN
let radioSettings: [SettingsItem] = [
    SettingsItem(type: .wifi, title: "Wi-Fi", icon: "wifi", color: .blue, destination: AnyView(NetworkView())),
    SettingsItem(type: .bluetooth, title: "Bluetooth", icon: "logo.bluetooth", color: .blue, destination: AnyView(BluetoothView())),
    SettingsItem(type: .cellular, title: "Cellular", icon: "antenna.radiowaves.left.and.right", color: .green, destination: AnyView(CellularView())),
    SettingsItem(type: .personalHotspot, title: "Personal Hotspot", icon: "personalhotspot", color: .green, destination: AnyView(HotspotView())),
]

// Attention Settings: Notifications, Screen Time
let attentionSettings: [SettingsItem] = [
    SettingsItem(type: .notifications, title: "Notifications", icon: "bell.badge.fill", color: .red, destination: AnyView(NotificationsView())),
    SettingsItem(type: .soundHaptics, title: DeviceInfo().isPhone ? "Sounds & Haptics" : "Sounds", icon: "speaker.3.fill", color: .pink, destination: AnyView(SoundsHapticsView())),
    SettingsItem(type: .focus, title: "Focus", icon: "moon.fill", color: .indigo, destination: AnyView(EmptyView())),
    SettingsItem(type: .screenTime, title: "Screen Time", icon: "hourglass", color: .indigo, destination: AnyView(ScreenTimeView())),
]

// Simulator Attention Settings: Screen Time
let attentionSimulatorSettings: [SettingsItem] = [
    SettingsItem(type: .screenTime, title: "Screen Time", icon: "hourglass", color: .indigo, destination: AnyView(ScreenTimeView())),
    SettingsItem(type: .actionButton, title: "Action Button", icon: "actionbutton_Normal", color: .blue, destination: AnyView(ActionButtonView()))
]

// Main Settings: General
let mainSettings: [SettingsItem] = [
    SettingsItem(type: .general, title: "General", icon: "gear", color: .gray, destination: AnyView(GeneralView())),
    SettingsItem(type: .controlCenter, title: "Control Center", icon: "switch.2", destination: AnyView(EmptyView())),
    SettingsItem(type: .actionButton, title: "Action Button", icon: "actionbutton_Normal", color: .blue, destination: AnyView(ActionButtonView())),
    SettingsItem(type: .displayBrightness, title: "Display & Brightness", icon: "sun.max.fill", color: .blue, destination: AnyView(EmptyView())),
    SettingsItem(type: .homeScreenAppLibrary, title: "Home Screen & App Library", icon: "applehome screen & app library", color: .indigo, destination: AnyView(EmptyView())),
    SettingsItem(type: .multitaskGestures, title: "Multitasking & Gestures", icon: "squares.leading.rectangle", color: .blue, destination: AnyView(MultitaskingGesturesView())),
    SettingsItem(type: .accessibility, title: "Accessibility", icon: "accessibility", color: .blue, destination: AnyView(AccessibilityView())),
    SettingsItem(type: .privacySecurity, title: "Privacy & Security", icon: "hand.raised.fill", color: .blue, destination: AnyView(PrivacySecurityView()))
]

// Services Settings: Passwords
let servicesSettings: [SettingsItem] = [
    SettingsItem(type: .passwords, title: "Passwords", icon: "key.fill", color: .gray, destination: AnyView(PasswordsView()))
]

// Apps Settings: Safari
let appsSettings: [SettingsItem] = [
    SettingsItem(type: .safari, title: "Safari", icon: "applesafari", destination: AnyView(SafariView())),
    SettingsItem(type: .news, title: "News", icon: "applenews", destination: AnyView(NewsView())),
    SettingsItem(type: .translate, title: "Translate", icon: "Placeholder_Normal", color: .white, destination: AnyView(TranslateView())),
    SettingsItem(type: .maps, title: "Maps", icon: "applemaps", destination: AnyView(MapsView())),
    SettingsItem(type: .shortcuts, title: "Shortcuts", icon: "appleshortcuts", destination: AnyView(ShortcutsView())),
    SettingsItem(type: .health, title: "Health", icon: "applehealth", destination: AnyView(HealthView())),
    SettingsItem(type: .siriSearch, title: "Siri & Search", icon: "applesiri", color: Color(UIColor.systemBackground), destination: AnyView(SiriSearchView())),
    SettingsItem(type: .photos, title: "Photos", icon: "applephotos", destination: AnyView(PhotosView())),
    SettingsItem(type: .gameCenter, title: "Game Center", icon: "applegamecenter", destination: AnyView(GameCenterView()))
]

// Developer Settings: Developer
let developerSettings: [SettingsItem] = [
    SettingsItem(type: .developer, title: "Developer", icon: "hammer.fill", color: .gray, destination: AnyView(DeveloperView()))
]

// Combined Settings Array
let combinedSettings = radioSettings + attentionSettings + mainSettings + servicesSettings + appsSettings + developerSettings
