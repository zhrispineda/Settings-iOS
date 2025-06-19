/*
Abstract:
A combination of structs, enums, and classes to define the structure of the app.
*/

import SwiftUI

// MARK: - Global variables
/// Global variables for access across views. (forceCellular, forcePhysical, developerMode)
struct Configuration {
    let forceCellular = false
    let forcePhysical = true
    let developerMode = true
}

let configuration = Configuration()

// MARK: - State Manager
/// Class for managing the state of the app's NavigationStack selection variable and destination view.
@Observable class StateManager {
    var destination = AnyView(GeneralView())
    var selection: SettingsModel? = .general
    var path: NavigationPath = NavigationPath()
}

protocol Routable: Hashable {
    func destination() -> AnyView
}

struct AnyRoute: Hashable {
    private let _destination: () -> AnyView
    private let base: AnyHashable
    
    init<R: Routable>(_ route: R) {
        self._destination = { AnyView(route.destination()) }
        self.base = AnyHashable(route)
    }
    
    func destination() -> AnyView {
        _destination()
    }
    
    static func == (lhs: AnyRoute, rhs: AnyRoute) -> Bool {
        return lhs.base == rhs.base
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(base)
    }
}

// MARK: - SettingsModel data
/// Stores the title of each enum variable for use in navigation.
enum SettingsModel: String, CaseIterable {
    case accessibility = "Accessibility"
    case actionButton = "Action Button"
    case appleIntelligence = "Apple Intelligence & Siri"
    case applePencil = "Apple Pencil"
    case apps = "Apps"
    case battery = "Battery"
    case faceIDPasscode = "Face ID & Passcode"
    case bluetooth = "Bluetooth"
    case camera = "Camera"
    case carrierSettings = "Carrier Settings"
    case cellular = "Cellular"
    case controlCenter = "Control Center"
    case developer = "Developer"
    case displayBrightness = "Display & Brightness"
    case emergencySOS = "Emergency SOS"
    case ethernet = "Ethernet"
    case focus = "Focus"
    case followUp = "Follow Up"
    case gameCenter = "Game Center"
    case general = "General"
    case homeScreenAppLibrary = "Home Screen & App Library"
    case icloud = "iCloud"
    case internalSettings = "Internal Settings"
    case multitaskGestures = "Multitasking & Gestures"
    case notifications = "Notifications"
    case personalHotspot = "Personal Hotspot"
    case privacySecurity = "Privacy & Security"
    case satellite = "Satellite"
    case screenTime = "Screen Time"
    case search = "Search"
    case siri = "Siri"
    case sounds = "Sounds"
    case soundsHaptics = "Sounds & Haptics"
    case standby = "StandBy"
    case touchIDPasscode = "Touch ID & Passcode"
    case wallet = "Wallet"
    case wallpaper = "Wallpaper"
    case wifi = "Wi-Fi"
}

/// Common device capabilities that are checked based on the current device.
enum Capabilities {
    case none
    case actionButton
    case cellular
    case ethernet
    case faceID
    case vpn
    case siri
    case sounds
    case soundsHaptics
    case touchID
    case appleIntelligence
    case isInternal
}

/// A struct for defining custom navigation links for use with sections of the app.
struct SettingsItem<Content: View>: Identifiable {
    var id: String { title }
    let type: SettingsModel
    var title: String { type.rawValue }
    let icon: String
    var capability: Capabilities = .none
    var color: Color = Color.white
    let destination: Content
}

// MARK: Icons
let smallerIcons: Set<String> = ["apple.logo", "appletvremote.gen4.fill", "apps.iphone", "apps.iphone.assistive.access", "apps.ipad", "arrow.counterclockwise", "bluetooth", "checkmark.seal.text.page.fill", "ear", "hand.raised.fill", "hourglass", "ipad.gen2", "iphone.badge.dot.radiowaves.up.forward", "iphone.gen1", "iphone.gen3", "mic.fill", "network.connected.to.line.below", "text.book.closed.fill"]
let largerIcons: Set<String> = ["waveform.and.magnifyingglass"]
let hierarchyIcons: Set<String> = ["faceid", "questionmark.app.dashed", "waveform.and.magnifyingglass"]
let internalIcons: Set<String> = ["airdrop", "app.grid.3x3", "apple.photos", "apps.iphone.assistive.access", "arrow.clockwise.app.stack.fill", "arrowtriangles.up.right.down.left.magnifyingglass", "bluetooth", "carplay", "chevron.3.up.perspective", "clock.filled.and.widget.filled", "ethernet", "eye.tracking", "figure.run.motion", "ipad.top.button.arrow.down", "iphone.action.button.arrow.right", "iphone.badge.dot.radiowaves.up.forward", "iphone.side.button.arrow.left", "keyboard.badge.waveform.fill", "key.dots.fill", "lock.and.ring.2", "lock.square.dotted", "nearby.interactions", "network.connected.to.line.below", "pencil.and.sparkles", "person.badge.waveform.fill", "ring.radiowaves.right", "satellite.fill", "sensorkit", "siri", "speaker.eye.fill", "voice.control", "waveform.arrow.triangle.branch.right", "waveform.bubble.fill"]
let multicolorIcons: Set<String> = ["app.grid.3x3", "faceid", "siri", "touchid"]

// MARK: - Settings Layout

/// Device-restricted views
let phoneOnly: Set<String> = ["Action Button", "Emergency SOS", "Health", "Personal Hotspot", "StandBy"]
let tabletOnly: Set<String> = ["Apple Pencil", "Multitasking & Gestures"]

/// Follow Up Settings
@MainActor
let followUpSettings: [SettingsItem] = [
    SettingsItem(type: .followUp, icon: "None", destination: AnyView(FollowUpView())),
]

/// Radio Settings
@MainActor
let radioSettings: [SettingsItem] = [
    SettingsItem(type: .wifi, icon: "com.apple.graphic-icon.wifi", destination: AnyView(NetworkView())),
    SettingsItem(type: .ethernet, icon: "com.apple.graphic-icon.ethernet", capability: .ethernet, destination: AnyView(EmptyView())),
    SettingsItem(type: .bluetooth, icon: "com.apple.graphic-icon.bluetooth", destination: AnyView(BluetoothView())),
    SettingsItem(type: .cellular, icon: "com.apple.graphic-icon.cellular-settings", capability: .cellular, destination: AnyView(CellularView())),
    //SettingsItem(type: .personalHotspot, icon: "personalhotspot", capability: .cellular, color: .green, destination: AnyView(HotspotView())),
    SettingsItem(type: .battery, icon: "com.apple.graphic-icon.battery", destination: AnyView(CustomViewController("/System/Library/PreferenceBundles/BatteryUsageUI.bundle/BatteryUsageUI", controller: "BatteryUIController"))),
    //SettingsItem(type: .satellite, icon: "satellite.fill", color: .black, destination: AnyView(EmptyView())),
]

/// Attention Settings
@MainActor
let attentionSettings: [SettingsItem] = [
    SettingsItem(type: .notifications, icon: "com.apple.graphic-icon.notifications", destination: AnyView(NotificationsView())),
    SettingsItem(type: .sounds, icon: "com.apple.graphic-icon.sound", capability: .sounds, destination: AnyView(BundleControllerView("/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework/SoundsAndHapticsSettings", controller: "SHSSoundsPrefController", title: "Sounds"))),
    SettingsItem(type: .soundsHaptics, icon: "com.apple.graphic-icon.sound", capability: .soundsHaptics, destination: AnyView(BundleControllerView("/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework/SoundsAndHapticsSettings", controller: "SHSSoundsPrefController", title: "Sounds & Haptics"))),
    SettingsItem(type: .focus, icon: "com.apple.graphic-icon.focus", destination: AnyView(FocusView())),
    SettingsItem(type: .screenTime, icon: "com.apple.graphic-icon.screen-time", destination: AnyView(ScreenTimeView())),
]

/// Simulator Attention Settings
@MainActor
let attentionSimulatorSettings: [SettingsItem] = [
    SettingsItem(type: .screenTime, icon: "com.apple.graphic-icon.screen-time", destination: AnyView(ScreenTimeView())),
]

/// Main Settings
@MainActor
let mainSettings: [SettingsItem] = [
    SettingsItem(type: .general, icon: "com.apple.graphic-icon.gear", destination: AnyView(GeneralView())),
    SettingsItem(type: .accessibility, icon: "com.apple.graphic-icon.accessibility", destination: AnyView(AccessibilityView())),
    SettingsItem(type: .actionButton, icon: "com.apple.graphic-icon.iphone-action-button", capability: .actionButton, destination: AnyView(BundleControllerView("ActionButtonSettings", controller: "ActionButtonSettings"))),
    SettingsItem(type: .applePencil, icon: "com.apple.graphic-icon.pencil", destination: AnyView(ApplePencilView())),
    SettingsItem(type: .appleIntelligence, icon: "com.apple.graphic-icon.intelligence", capability: .appleIntelligence, destination: AnyView(SiriView())),
    SettingsItem(type: .camera, icon: "com.apple.graphic-icon.camera", destination: AnyView(CameraView())),
    SettingsItem(type: .controlCenter, icon: "com.apple.graphic-icon.control-center", destination: AnyView(BundleControllerView("ControlCenterSettings", controller: "ControlCenterSettingsViewController", title: "Control Center"))),
    SettingsItem(type: .displayBrightness, icon: "com.apple.graphic-icon.display", destination: AnyView(DisplayBrightnessView())),
    SettingsItem(type: .homeScreenAppLibrary, icon: UIDevice.iPhone ? "com.apple.graphic-icon.apps-on-iphone" : "com.apple.graphic-icon.apps-on-ipad", destination: AnyView(HomeScreenAppLibraryView())),
    SettingsItem(type: .multitaskGestures, icon: "com.apple.graphic-icon.stage-manager", destination: AnyView(BundleControllerView("MultitaskingAndGesturesSettings", controller: "MultitaskingAndGesturesSettings", title: "Multitasking & Gestures"))),
    SettingsItem(type: .search, icon: "com.apple.graphic-icon.search", destination: AnyView(SearchView())),
    SettingsItem(type: .siri, icon: "com.apple.application-icon.siri", capability: .siri, destination: AnyView(SiriView())),
    SettingsItem(type: .standby, icon: "com.apple.graphic-icon.standby", destination: AnyView(StandByView())),
    SettingsItem(type: .wallpaper, icon: "com.apple.graphic-icon.wallpaper", destination: AnyView(BundleControllerView("WallpaperSettings", controller: "WallpaperSettingsRootViewController"))),
]

/// Simulator Main Settings
@MainActor
let simulatorMainSettings: [SettingsItem] = [
    SettingsItem(type: .general, icon: "com.apple.graphic-icon.gear", destination: AnyView(GeneralView())),
    SettingsItem(type: .accessibility, icon: "com.apple.graphic-icon.accessibility", destination: AnyView(AccessibilityView())),
    SettingsItem(type: .appleIntelligence, icon: "com.apple.graphic-icon.intelligence", destination: AnyView(SiriView())),
    SettingsItem(type: .actionButton, icon: "com.apple.graphic-icon.iphone-action-button", capability: .actionButton, destination: AnyView(BundleControllerView("ActionButtonSettings", controller: "ActionButtonSettings"))),
    SettingsItem(type: .camera, icon: "com.apple.graphic-icon.camera", destination: AnyView(CameraView())),
    SettingsItem(type: .homeScreenAppLibrary, icon: UIDevice.iPhone ? "com.apple.graphic-icon.apps-on-iphone" : "com.apple.graphic-icon.apps-on-ipad", destination: AnyView(HomeScreenAppLibraryView())),
    SettingsItem(type: .multitaskGestures, icon: "com.apple.graphic-icon.stage-manager", destination: AnyView(BundleControllerView("MultitaskingAndGesturesSettings", controller: "MultitaskingAndGesturesSettings", title: "Multitasking & Gestures"))),
    SettingsItem(type: .search, icon: "com.apple.graphic-icon.search", destination: AnyView(SearchView())),
    SettingsItem(type: .siri, icon: "com.apple.graphic-icon.intelligence", capability: .siri, destination: AnyView(SiriView())),
    SettingsItem(type: .standby, icon: "com.apple.graphic-icon.standby", destination: AnyView(StandByView())),
]

/// Security Settings
@MainActor
let securitySettings: [SettingsItem] = [
    SettingsItem(type: .faceIDPasscode, icon: "com.apple.graphic-icon.face-id", capability: .faceID, destination: AnyView(BiometricPasscodeView())),
    SettingsItem(type: .touchIDPasscode, icon: "com.apple.graphic-icon.touch-id", capability: .touchID, destination: AnyView(BiometricPasscodeView())),
    SettingsItem(type: .emergencySOS, icon: "com.apple.graphic-icon.emergency-sos", destination: AnyView(BundleControllerView("SOSSettings", controller: "SOSSettingsController", title: "Emergency SOS"))),
    SettingsItem(type: .privacySecurity, icon: "com.apple.graphic-icon.privacy", destination: AnyView(PrivacySecurityView()))
]

/// Simulator Security Settings
@MainActor
let simulatorSecuritySettings: [SettingsItem] = [
    SettingsItem(type: .privacySecurity, icon: "com.apple.graphic-icon.privacy", destination: AnyView(PrivacySecurityView()))
]

/// Services Settings
@MainActor
let serviceSettings: [SettingsItem] = [
    SettingsItem(type: .gameCenter, icon: "com.apple.gamecenter.bubbles", destination: AnyView(BundleControllerView("/System/Library/PrivateFrameworks/GameCenterUI.framework/GameCenterUI", controller: "GameCenterUI.SettingsContainerViewController", title: "Game Center"))),
    SettingsItem(type: .icloud, icon: "com.apple.application-icon.icloud", destination: AnyView(EmptyView())),
    SettingsItem(type: .wallet, icon: "com.apple.Passbook", destination: AnyView(WalletView()))
]

/// Simulator Service Settings
@MainActor
let simulatorServicesSettings: [SettingsItem] = [
    SettingsItem(type: .gameCenter, icon: "com.apple.gamecenter.bubbles", color: .white, destination: AnyView(BundleControllerView("/System/Library/PrivateFrameworks/GameCenterUI.framework/GameCenterUI", controller: "GameCenterUI.SettingsContainerViewController", title: "Game Center"))),
    SettingsItem(type: .icloud, icon: "com.apple.application-icon.icloud", destination: AnyView(EmptyView()))
]

/// App Settings
@MainActor
let appsSettings: [SettingsItem] = [
    SettingsItem(type: .apps, icon: "com.apple.graphic-icon.home-screen", destination: AnyView(AppsView()))
]

/// Developer Settings
@MainActor
let developerSettings: [SettingsItem] = [
    SettingsItem(type: .developer, icon: "com.apple.graphic-icon.developer-tools", destination: AnyView(BundleControllerView("DeveloperSettings", controller: "DTSettings", title: "Developer"))),
    SettingsItem(type: .carrierSettings, icon: "com.apple.graphic-icon.carrier-settings", capability: .isInternal, destination: AnyView(EmptyView())),
    SettingsItem(type: .internalSettings, icon: "com.apple.graphic-icon.internal-settings", capability: .isInternal, destination: AnyView(EmptyView()))
]

/// Combined Settings
@MainActor
let combinedSettings = followUpSettings + radioSettings + attentionSettings + mainSettings + securitySettings + serviceSettings + simulatorServicesSettings + appsSettings + developerSettings + simulatorMainSettings + simulatorSecuritySettings
