//
//  SettingsModel.swift
//  Preferences
//

import SwiftUI

// MARK: Global variables
struct Configuration {
    let forceCellular = false
    let forcePhysical = true
    let developerMode = true
}

// MARK: - SettingsModel data
enum SettingsModel: String, CaseIterable {
    case accessibility = "Accessibility"
    case actionButton = "Action Button"
    case applePencil = "Apple Pencil"
    case apps = "Apps"
    case appStore = "App Store"
    case battery = "Battery"
    case biometricPasscode = "Biometric & Passcode"
    case bluetooth = "Bluetooth"
    case camera = "Camera"
    case cellular = "Cellular"
    case controlCenter = "Control Center"
    case developer = "Developer"
    case displayBrightness = "Display & Brightness"
    case emergencySOS = "Emergency SOS"
    case focus = "Focus"
    case gameCenter = "Game Center"
    case general = "General"
    case homeScreenAppLibrary = "Home Screen & App Library"
    case icloud = "iCloud"
    case multitaskGestures = "Multitasking & Gestures"
    case notifications = "Notifications"
    case personalHotspot = "Personal Hotspot"
    case privacySecurity = "Privacy & Security"
    case satellite = "Satellite"
    case screenTime = "Screen Time"
    case search = "Search"
    case siri = "Siri"
    case soundHaptics = "Sound & Haptics"
    case standby = "StandBy"
    case wallet = "Wallet"
    case wallpaper = "Wallpaper"
    case wifi = "Wi-Fi"
}

enum Capabilities {
    case none
    case actionButton
    case cellular
    case vpn
}

struct SettingsItem<Content: View>: Identifiable {
    var id: String { title }
    let type: SettingsModel
    let title: String
    let icon: String
    var capability: Capabilities = .none
    var color: Color = Color.gray
    let destination: Content
}

// MARK: Icons information
let smallerIcons = ["appletvremote.gen4.fill", "apps.iphone", "apps.iphone.assistive.access", "apps.ipad", "arrow.counterclockwise", "bluetooth", "checkmark.seal.text.page.fill", "ear", "hand.raised.fill", "hourglass", "ipad.gen2", "iphone", "iphone.badge.dot.radiowaves.up.forward", "iphone.gen1", "iphone.gen3", "lock.fill", "mic.fill", "shield.fill", "text.book.closed.fill"]
let largerIcons = ["waveform.and.magnifyingglass"]
let hierarchyIcons = ["faceid", "questionmark.app.dashed", "questionmark.square.dashed", "waveform.and.magnifyingglass"]
let internalIcons = ["airdrop", "apple.photos", "apps.iphone.assistive.access", "arrow.clockwise.app.stack.fill", "arrowtriangles.up.right.down.left.magnifyingglass", "bluetooth", "carplay", "chevron.3.up.perspective", "clock.filled.and.widget.filled", "eye.tracking", "figure.run.motion", "ipad.top.button.arrow.down", "iphone.action.button.arrow.right", "iphone.badge.dot.radiowaves.up.forward", "iphone.side.button.arrow.left", "keyboard.badge.waveform.fill", "key.dots.fill", "lock.square.dotted", "nearby.interactions", "network.connected.to.line.below", "pencil.and.sparkles", "person.badge.waveform.fill", "satellite.fill", "sensorkit", "speaker.eye.fill", "voice.control", "waveform.arrow.triangle.branch.right", "waveform.bubble.fill"]

// MARK: - Settings Layout
// MARK: Radio Settings
@MainActor let radioSettings: [SettingsItem] = [
    SettingsItem(type: .wifi, title: "Wi-Fi", icon: "wifi", color: .blue, destination: AnyView(NetworkView())),
    SettingsItem(type: .bluetooth, title: "Bluetooth", icon: "bluetooth", color: .blue, destination: AnyView(BluetoothView())),
    SettingsItem(type: .cellular, title: "Cellular", icon: "antenna.radiowaves.left.and.right", capability: .cellular, color: .green, destination: AnyView(CellularView())),
    //SettingsItem(type: .personalHotspot, title: "Personal Hotspot", icon: "personalhotspot", capability: .cellular, color: .green, destination: AnyView(HotspotView())),
    SettingsItem(type: .battery, title: "Battery", icon: "battery.100percent", color: .green, destination: AnyView(BatteryView())),
    //SettingsItem(type: .satellite, title: "Satellite", icon: "satellite.fill", color: .black, destination: AnyView(EmptyView())),
]

// MARK: Attention Settings
@MainActor let attentionSettings: [SettingsItem] = [
    SettingsItem(type: .notifications, title: "Notifications", icon: "bell.badge.fill", color: .red, destination: AnyView(NotificationsView())),
    SettingsItem(type: .soundHaptics, title: UIDevice.iPhone ? "Sounds & Haptics" : "Sounds", icon: "speaker.3.fill", color: .pink, destination: AnyView(SoundsHapticsView())),
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
    SettingsItem(type: .actionButton, title: "Action Button", icon: "iphone.action.button.arrow.right", capability: .actionButton, color: .blue, destination: AnyView(ActionButtonView())),
    SettingsItem(type: .applePencil, title: "Apple Pencil", icon: "pencil", color: .gray, destination: AnyView(ApplePencilView())),
    //SettingsItem(type: .siri, title: "Apple Intelligence & Siri", icon: "appleIntelligence", color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
    SettingsItem(type: .camera, title: "Camera", icon: "camera.fill", color: .gray, destination: AnyView(CameraView())),
    SettingsItem(type: .controlCenter, title: "Control Center", icon: "switch.2", destination: AnyView(ControlCenterView())),
    SettingsItem(type: .displayBrightness, title: "Display & Brightness", icon: "sun.max.fill", color: .blue, destination: AnyView(DisplayBrightnessView())),
    SettingsItem(type: .homeScreenAppLibrary, title: "Home Screen & App Library", icon: UIDevice.iPhone ? "apps.iphone" : "apps.ipad", color: .blue, destination: AnyView(HomeScreenAppLibraryView())),
    SettingsItem(type: .multitaskGestures, title: "Multitasking & Gestures", icon: "squares.leading.rectangle", color: .blue, destination: AnyView(MultitaskingGesturesView())),
    SettingsItem(type: .search, title: "Search", icon: "magnifyingglass", color: .gray, destination: AnyView(SearchView())),
    SettingsItem(type: .siri, title: "Siri", icon: "appleSiri", color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
    SettingsItem(type: .standby, title: "StandBy", icon: "clock.filled.and.widget.filled", color: .black, destination: AnyView(StandByView())),
    SettingsItem(type: .wallpaper, title: "Wallpaper", icon: "apple.photos", color: .cyan, destination: AnyView(WallpaperView())),
]

// MARK: Simulator Main Settings
@MainActor let simulatorMainSettings: [SettingsItem] = [
    SettingsItem(type: .general, title: "General", icon: "gear", color: .gray, destination: AnyView(GeneralView())),
    SettingsItem(type: .accessibility, title: "Accessibility", icon: "accessibility", color: .blue, destination: AnyView(AccessibilityView())),
    //SettingsItem(type: .siri, title: "Apple Intelligence & Siri", icon: "appleIntelligence", color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
    SettingsItem(type: .actionButton, title: "Action Button", icon: "iphone.action.button.arrow.right", capability: .actionButton, color: .blue, destination: AnyView(ActionButtonView())),
    SettingsItem(type: .camera, title: "Camera", icon: "camera.fill", color: .gray, destination: AnyView(CameraView())),
    SettingsItem(type: .homeScreenAppLibrary, title: "Home Screen & App Library", icon: "apps.iphone", color: .blue, destination: AnyView(HomeScreenAppLibraryView())),
    SettingsItem(type: .multitaskGestures, title: "Multitasking & Gestures", icon: "squares.leading.rectangle", color: .blue, destination: AnyView(MultitaskingGesturesView())),
    SettingsItem(type: .search, title: "Search", icon: "magnifyingglass", color: .gray, destination: AnyView(SearchView())),
    SettingsItem(type: .siri, title: "Siri", icon: "appleSiri", color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
    SettingsItem(type: .standby, title: "StandBy", icon: "clock.filled.and.widget.filled", color: .black, destination: AnyView(StandByView())),
]

// MARK: Security Settings
@MainActor let securitySettings: [SettingsItem] = [
    SettingsItem(type: .biometricPasscode, title: "\(UIDevice.PearlIDCapability ? "Face" : "Touch") ID & Passcode", icon: UIDevice.PearlIDCapability ? "faceid" : "lock.fill", color: UIDevice.PearlIDCapability ? .green : .red, destination: AnyView(BiometricPasscodeView())),
    SettingsItem(type: .emergencySOS, title: "Emergency SOS", icon: "sos", color: .red, destination: AnyView(EmergencyView())),
    SettingsItem(type: .privacySecurity, title: "Privacy & Security", icon: "hand.raised.fill", color: .blue, destination: AnyView(PrivacySecurityView()))
]

// MARK: Simulator Security Settings
@MainActor let simulatorSecuritySettings: [SettingsItem] = [
    SettingsItem(type: .privacySecurity, title: "Privacy & Security", icon: "hand.raised.fill", color: .blue, destination: AnyView(PrivacySecurityView()))
]

// MARK: Services Settings
@MainActor let serviceSettings: [SettingsItem] = [
    SettingsItem(type: .appStore, title: "App Store", icon: "appleAppStore", destination: UIDevice.IsSimulator ? AnyView(EmptyView()) : AnyView(AppStoreView())),
    SettingsItem(type: .gameCenter, title: "Game Center", icon: "appleGameCenter", destination: AnyView(GameCenterView())),
    SettingsItem(type: .icloud, title: "iCloud", icon: "iCloud", destination: AnyView(EmptyView())),
    SettingsItem(type: .wallet, title: "Wallet & Apple Pay", icon: "appleWallet", destination: AnyView(WalletView()))
]

// MARK: Simulator Service Settings
@MainActor let simulatorServiceSettings: [SettingsItem] = [
    SettingsItem(type: .gameCenter, title: "Game Center", icon: "Placeholder", color: .black, destination: AnyView(GameCenterView())),
    SettingsItem(type: .icloud, title: "iCloud", icon: "iCloud", destination: AnyView(EmptyView())),
    SettingsItem(type: .wallet, title: "Wallet & Apple Pay", icon: "appleWallet", destination: AnyView(WalletView()))
]

// MARK: App Settings
@MainActor let appsSettings: [SettingsItem] = [
    SettingsItem(type: .apps, title: "Apps", icon: "appleHome Screen & App Library", color: .indigo, destination: AnyView(AppsView()))
]

// MARK: Developer Settings
@MainActor let developerSettings: [SettingsItem] = [
    SettingsItem(type: .developer, title: "Developer", icon: "hammer.fill", color: .gray, destination: AnyView(DeveloperView()))
]

// MARK: Combined Settings Array
@MainActor let combinedSettings = radioSettings + attentionSettings + mainSettings + securitySettings + serviceSettings + appsSettings + developerSettings + simulatorMainSettings + simulatorSecuritySettings
