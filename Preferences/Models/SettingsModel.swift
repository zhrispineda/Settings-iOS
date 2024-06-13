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
    let developerMode = true
}

// MARK: Color extension
extension Color {
    static subscript(name: String) -> Color {
        switch name {
        case "Label":
            return Color(UIColor.label)
        case "Hightlight":
            return Color(red: 0.0, green: 1.0, blue: 1.0)
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
@MainActor
class Device: ObservableObject {
    @Published var model: String = UIDevice.current.localizedModel
    
    var isPhone = UIDevice.current.localizedModel == "iPhone"
    var isTablet = UIDevice.current.localizedModel == "iPad"
    var isPro = UIDevice.current.name.contains("Pro")
    var isLargestTablet = UIDevice.current.name.contains("12.9")
    var isStageManagerCapable = UIDevice.current.name.contains("Air (5th") || UIDevice.current.name.contains("M2") || UIDevice.current.name.contains("M4") || UIDevice.current.name.contains("Pro (11") || UIDevice.current.name.contains("(12.9-inch) (3") || UIDevice.current.name.contains("(12.9-inch) (4") || UIDevice.current.name.contains("(12.9-inch) (5") || UIDevice.current.name.contains("(12.9-inch) (6")
    var hasHomeButton = UIDevice.current.name.contains("SE")
    var hasFaceAuth = !UIDevice.current.name.contains("SE") && !UIDevice.current.name.contains("Air") && !UIDevice.current.name.contains("iPad (") && !UIDevice.current.name.contains("iPad mini")
    var hasAlwaysOnDisplay = UIDevice.current.name.contains("14 Pro") || UIDevice.current.name.contains("15 Pro")
    var hasExtraBatteryFeatures = UIDevice.current.name.contains("15") || (UIDevice.current.name.contains("Air") && UIDevice.current.name.contains("M2")) || UIDevice.current.name.contains("M4")
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
    case camera = "Camera"
    case homeScreenAppLibrary = "Home Screen & App Library"
    case multitaskGestures = "Multitasking & Gestures"
    case accessibility = "Accessibility"
    case wallpaper = "Wallpaper"
    case search = "Search"
    case standby = "StandBy"
    case battery = "Battery"
    case privacySecurity = "Privacy & Security"
    
    case biometricPasscode = "Biometric & Passcode"
    case emergencySOS = "Emergency SOS"
    
    case safari = "Safari"
    case news = "News"
    case translate = "Translate"
    case maps = "Maps"
    case shortcuts = "Shortcuts"
    case health = "Health"
    case siri = "Siri"
    case photos = "Photos"
    case appStore = "App Store"
    case gameCenter = "Game Center"
    case wallet = "Wallet & Apple Pay"
    
    case apps = "Apps"
    
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

// Icon scaling
let smallerIcons = ["airplane", "arrow.turn.up.forward.iphone", "calendar.badge.clock", "character.book.closed.fill", "eye.trianglebadge.exclamationmark.fill", "sos", "pip", "key.fill", "shareplay"]
let largerIcons = ["accessibility", "bell.badge.fill", "faceid", "gear", "hand.raised.fill", "hourglass"]

// MARK: Radio Settings
@MainActor let radioSettings: [SettingsItem] = [
    SettingsItem(type: .wifi, title: "Wi-Fi", icon: "wifi", color: .blue, destination: AnyView(NetworkView())),
    SettingsItem(type: .bluetooth, title: "Bluetooth", icon: "bluetooth", color: .blue, destination: AnyView(BluetoothView())),
    SettingsItem(type: .cellular, title: "Cellular", icon: "antenna.radiowaves.left.and.right", color: .green, destination: AnyView(CellularView())),
    SettingsItem(type: .battery, title: "Battery", icon: "battery.100percent", color: .green, destination: AnyView(BatteryView())),
    SettingsItem(type: .personalHotspot, title: "Personal Hotspot", icon: "personalhotspot", color: .green, destination: AnyView(HotspotView())),
]

// MARK: Attention Settings
@MainActor let attentionSettings: [SettingsItem] = [
    SettingsItem(type: .notifications, title: "Notifications", icon: "bell.badge.fill", color: .red, destination: AnyView(NotificationsView())),
    SettingsItem(type: .soundHaptics, title: Device().isPhone ? "Sounds & Haptics" : "Sounds", icon: "speaker.3.fill", color: .pink, destination: AnyView(SoundsHapticsView())),
    SettingsItem(type: .focus, title: "Focus", icon: "moon.fill", color: .indigo, destination: AnyView(FocusView())),
    SettingsItem(type: .screenTime, title: "Screen Time", icon: "hourglass", color: .indigo, destination: AnyView(ScreenTimeView())),
]

// MARK: Simulator Attention Settings
@MainActor let attentionSimulatorSettings: [SettingsItem] = [
    SettingsItem(type: .screenTime, title: "Screen Time", icon: "hourglass", color: .indigo, destination: AnyView(ScreenTimeView())),
]

// MARK: Main Settings
@MainActor let mainSettings: [SettingsItem] = [
    SettingsItem(type: .general, title: "General", icon: "gear", color: .gray, destination: AnyView(GeneralView())),
    SettingsItem(type: .accessibility, title: "Accessibility", icon: "accessibility", color: .blue, destination: AnyView(AccessibilityView())),
    SettingsItem(type: .actionButton, title: "Action Button", icon: "actionbutton", color: .blue, destination: AnyView(ActionButtonView())),
    SettingsItem(type: .camera, title: "Camera", icon: "camera.fill", color: .gray, destination: AnyView(EmptyView())),
    SettingsItem(type: .controlCenter, title: "Control Center", icon: "switch.2", destination: AnyView(ControlCenterView())),
    SettingsItem(type: .displayBrightness, title: "Display & Brightness", icon: "sun.max.fill", color: .blue, destination: AnyView(DisplayBrightnessView())),
    SettingsItem(type: .homeScreenAppLibrary, title: "Home Screen & App Library", icon: Device().isPhone ? "apps.iphone" : "apps.ipad", color: .blue, destination: AnyView(EmptyView())),
    SettingsItem(type: .multitaskGestures, title: "Multitasking & Gestures", icon: "squares.leading.rectangle", color: .blue, destination: AnyView(MultitaskingGesturesView())),
    SettingsItem(type: .search, title: "Search", icon: "magnifyingglass", color: .gray, destination: AnyView(EmptyView())),
    SettingsItem(type: .siri, title: "Siri", icon: "applesiri", color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
    SettingsItem(type: .standby, title: "StandBy", icon: "applestandby", destination: AnyView(EmptyView())),
    SettingsItem(type: .wallpaper, title: "Wallpaper", icon: "Wallpaper", color: .clear, destination: AnyView(EmptyView())),
]

// MARK: Simulator Main Settings
@MainActor let simulatorMainSettings: [SettingsItem] = [
    SettingsItem(type: .general, title: "General", icon: "gear", color: .gray, destination: AnyView(GeneralView())),
    SettingsItem(type: .accessibility, title: "Accessibility", icon: "accessibility", color: .blue, destination: AnyView(AccessibilityView())),
    SettingsItem(type: .actionButton, title: "Action Button", icon: "actionbutton", color: .blue, destination: AnyView(ActionButtonView())),
    SettingsItem(type: .camera, title: "Camera", icon: "camera.fill", color: .gray, destination: AnyView(EmptyView())),
    SettingsItem(type: .homeScreenAppLibrary, title: "Home Screen & App Library", icon: "apps.iphone", color: .blue, destination: AnyView(EmptyView())),
    SettingsItem(type: .multitaskGestures, title: "Multitasking & Gestures", icon: "squares.leading.rectangle", color: .blue, destination: AnyView(MultitaskingGesturesView())),
    SettingsItem(type: .search, title: "Search", icon: "magnifyingglass", color: .gray, destination: AnyView(EmptyView())),
    SettingsItem(type: .siri, title: "Siri", icon: "applesiri", color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
]

// MARK: Security Settings
@MainActor let securitySettings: [SettingsItem] = [
    SettingsItem(type: .biometricPasscode, title: "\(Device().hasFaceAuth ? "Face" : "Touch") ID & Passcode", icon: Device().hasFaceAuth ? "faceid" : "lock.fill", color: Device().hasFaceAuth ? .green : .red, destination: AnyView(EmptyView())),
    SettingsItem(type: .emergencySOS, title: "Emergency SOS", icon: "sos", color: .red, destination: AnyView(EmptyView())),
    SettingsItem(type: .privacySecurity, title: "Privacy & Security", icon: "hand.raised.fill", color: .blue, destination: AnyView(PrivacySecurityView()))
]

// MARK: Simulator Security Settings
@MainActor let simulatorSecuritySettings: [SettingsItem] = [
    SettingsItem(type: .privacySecurity, title: "Privacy & Security", icon: "hand.raised.fill", color: .blue, destination: AnyView(PrivacySecurityView()))
]

// MARK: Services Settings
@MainActor let serviceSettings: [SettingsItem] = [
    //SettingsItem(type: .passwords, title: "Passwords", icon: "key.fill", color: .gray, destination: AnyView(PasswordsView()))
    SettingsItem(type: .appStore, title: "App Store", icon: Configuration().isSimulator ? "Placeholder_Normal" : "appleappstore", destination: AnyView(EmptyView())),
    SettingsItem(type: .gameCenter, title: "Game Center", icon: Configuration().isSimulator ? "Placeholder_Normal" : "applegamecenter", destination: AnyView(GameCenterView())),
    SettingsItem(type: .wallet, title: "Wallet & Apple Pay", icon: "applewallet", destination: AnyView(EmptyView()))
]

// MARK: App Settings
@MainActor let appSettings: [SettingsItem] = [
    SettingsItem(type: .apps, title: "Apps", icon: "applehome screen & app library", color: .indigo, destination: AnyView(EmptyView()))
]

// MARK: Developer Settings
@MainActor let developerSettings: [SettingsItem] = [
    SettingsItem(type: .developer, title: "Developer", icon: "hammer.fill", color: .gray, destination: AnyView(DeveloperView()))
]

// MARK: Combined Settings Array
@MainActor let combinedSettings = radioSettings + attentionSettings + mainSettings + securitySettings + serviceSettings + appSettings + developerSettings + simulatorMainSettings + simulatorSecuritySettings
