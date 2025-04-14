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
class StateManager: ObservableObject {
    @Published var destination = AnyView(GeneralView())
    @Published var selection: SettingsModel? = .general
    @Published var path: NavigationPath = NavigationPath()
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
let smallerIcons = ["apple.logo", "appletvremote.gen4.fill", "apps.iphone", "apps.iphone.assistive.access", "apps.ipad", "arrow.counterclockwise", "bluetooth", "checkmark.seal.text.page.fill", "ear", "hand.raised.fill", "hourglass", "ipad.gen2", "iphone.badge.dot.radiowaves.up.forward", "iphone.gen1", "iphone.gen3", "mic.fill", "network.connected.to.line.below", "text.book.closed.fill"]
let largerIcons = ["waveform.and.magnifyingglass"]
let hierarchyIcons = ["faceid", "questionmark.app.dashed", "waveform.and.magnifyingglass"]
let internalIcons = ["airdrop", "app.grid.3x3", "apple.photos", "apps.iphone.assistive.access", "arrow.clockwise.app.stack.fill", "arrowtriangles.up.right.down.left.magnifyingglass", "bluetooth", "carplay", "chevron.3.up.perspective", "clock.filled.and.widget.filled", "ethernet", "eye.tracking", "figure.run.motion", "ipad.top.button.arrow.down", "iphone.action.button.arrow.right", "iphone.badge.dot.radiowaves.up.forward", "iphone.side.button.arrow.left", "keyboard.badge.waveform.fill", "key.dots.fill", "lock.and.ring.2", "lock.square.dotted", "nearby.interactions", "network.connected.to.line.below", "pencil.and.sparkles", "person.badge.waveform.fill", "ring.radiowaves.right", "satellite.fill", "sensorkit", "siri", "speaker.eye.fill", "voice.control", "waveform.arrow.triangle.branch.right", "waveform.bubble.fill"]
let multicolorIcons = ["app.grid.3x3", "faceid", "siri", "touchid"]

// MARK: - Settings Layout

/// Follow Up Settings
@MainActor
let followUpSettings: [SettingsItem] = [
    SettingsItem(type: .followUp, icon: "None", destination: AnyView(FollowUpView())),
]

/// Radio Settings
@MainActor
let radioSettings: [SettingsItem] = [
    SettingsItem(type: .wifi, icon: "wifi", color: .blue, destination: AnyView(NetworkView())),
    SettingsItem(type: .ethernet, icon: "ethernet", capability: .ethernet, color: .gray, destination: AnyView(EmptyView())),
    SettingsItem(type: .bluetooth, icon: "bluetooth", color: .blue, destination: AnyView(BluetoothView())),
    SettingsItem(type: .cellular, icon: "antenna.radiowaves.left.and.right", capability: .cellular, color: .green, destination: AnyView(CellularView())),
    //SettingsItem(type: .personalHotspot, icon: "personalhotspot", capability: .cellular, color: .green, destination: AnyView(HotspotView())),
    SettingsItem(type: .battery, icon: "battery.100percent", color: .green, destination: AnyView(BatteryView())),
    //SettingsItem(type: .satellite, icon: "satellite.fill", color: .black, destination: AnyView(EmptyView())),
]

/// Attention Settings
@MainActor
let attentionSettings: [SettingsItem] = [
    SettingsItem(type: .notifications, icon: "bell.badge.fill", color: .red, destination: AnyView(NotificationsView())),
    SettingsItem(type: .sounds, icon: "speaker.3.fill", capability: .sounds, color: .pink, destination: AnyView(BundleControllerView("/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework/SoundsAndHapticsSettings", controller: "SHSSoundsPrefController", title: "Sounds"))),
    SettingsItem(type: .soundsHaptics, icon: "speaker.3.fill", capability: .soundsHaptics, color: .pink, destination: AnyView(BundleControllerView("/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework/SoundsAndHapticsSettings", controller: "SHSSoundsPrefController", title: "Sounds & Haptics"))),
    SettingsItem(type: .focus, icon: "moon.fill", color: .indigo, destination: AnyView(FocusView())),
    SettingsItem(type: .screenTime, icon: "hourglass", color: .indigo, destination: AnyView(ScreenTimeView())),
]

/// Simulator Attention Settings
@MainActor
let attentionSimulatorSettings: [SettingsItem] = [
    SettingsItem(type: .screenTime, icon: "hourglass", color: .indigo, destination: AnyView(ScreenTimeView())),
]

/// Main Settings
@MainActor
let mainSettings: [SettingsItem] = [
    SettingsItem(type: .general, icon: "gear", color: .gray, destination: AnyView(GeneralView())),
    SettingsItem(type: .accessibility, icon: "accessibility", color: .blue, destination: AnyView(AccessibilityView())),
    SettingsItem(type: .actionButton, icon: "iphone.action.button.arrow.right", capability: .actionButton, color: .blue, destination: AnyView(BundleControllerView("ActionButtonSettings", controller: "ActionButtonSettings"))),
    SettingsItem(type: .applePencil, icon: "pencil", color: .gray, destination: AnyView(ApplePencilView())),
    SettingsItem(type: .appleIntelligence, icon: "appleIntelligence", capability: .appleIntelligence, color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
    SettingsItem(type: .camera, icon: "camera.fill", color: .gray, destination: AnyView(CameraView())),
    SettingsItem(type: .controlCenter, icon: "switch.2", color: .gray, destination: AnyView(BundleControllerView("ControlCenterSettings", controller: "ControlCenterSettingsViewController", title: "Control Center"))),
    SettingsItem(type: .displayBrightness, icon: "sun.max.fill", color: .blue, destination: AnyView(DisplayBrightnessView())),
    SettingsItem(type: .homeScreenAppLibrary, icon: UIDevice.iPhone ? "apps.iphone" : "apps.ipad", color: .blue, destination: AnyView(HomeScreenAppLibraryView())),
    SettingsItem(type: .multitaskGestures, icon: "squares.leading.rectangle", color: .blue, destination: AnyView(BundleControllerView("MultitaskingAndGesturesSettings", controller: "MultitaskingAndGesturesSettings", title: "Multitasking & Gestures"))),
    SettingsItem(type: .search, icon: "magnifyingglass", color: .gray, destination: AnyView(SearchView())),
    SettingsItem(type: .siri, icon: "appleSiri", capability: .siri, color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
    SettingsItem(type: .standby, icon: "clock.filled.and.widget.filled", color: .black, destination: AnyView(StandByView())),
    SettingsItem(type: .wallpaper, icon: "apple.photos", color: .cyan, destination: AnyView(BundleControllerView("WallpaperSettings", controller: "WallpaperSettingsRootViewController"))),
]

/// Simulator Main Settings
@MainActor
let simulatorMainSettings: [SettingsItem] = [
    SettingsItem(type: .general, icon: "gear", color: .gray, destination: AnyView(GeneralView())),
    SettingsItem(type: .accessibility, icon: "accessibility", color: .blue, destination: AnyView(AccessibilityView())),
    SettingsItem(type: .siri, icon: "appleIntelligenceSimulator", capability: .appleIntelligence, color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
    SettingsItem(type: .actionButton, icon: "iphone.action.button.arrow.right", capability: .actionButton, color: .blue, destination: AnyView(BundleControllerView("ActionButtonSettings", controller: "ActionButtonSettings"))),
    SettingsItem(type: .camera, icon: "camera.fill", color: .gray, destination: AnyView(CameraView())),
    SettingsItem(type: .homeScreenAppLibrary, icon: "apps.iphone", color: .blue, destination: AnyView(HomeScreenAppLibraryView())),
    SettingsItem(type: .multitaskGestures, icon: "squares.leading.rectangle", color: .blue, destination: AnyView(BundleControllerView("MultitaskingAndGesturesSettings", controller: "MultitaskingAndGesturesSettings", title: "Multitasking & Gestures"))),
    SettingsItem(type: .search, icon: "magnifyingglass", color: .gray, destination: AnyView(SearchView())),
    SettingsItem(type: .siri, icon: "appleSiri", capability: .siri, color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
    SettingsItem(type: .standby, icon: "clock.filled.and.widget.filled", color: .black, destination: AnyView(StandByView())),
]

/// Security Settings
@MainActor
let securitySettings: [SettingsItem] = [
    SettingsItem(type: .faceIDPasscode, icon: "faceid", capability: .faceID, color: .green, destination: AnyView(BiometricPasscodeView())),
    SettingsItem(type: .touchIDPasscode, icon: "touchid", capability: .touchID, color: .white, destination: AnyView(BiometricPasscodeView())),
    SettingsItem(type: .emergencySOS, icon: "sos", color: .red, destination: AnyView(BundleControllerView("SOSSettings", controller: "SOSSettingsController", title: "Emergency SOS"))),
    SettingsItem(type: .privacySecurity, icon: "hand.raised.fill", color: .blue, destination: AnyView(PrivacySecurityView()))
]

/// Simulator Security Settings
@MainActor
let simulatorSecuritySettings: [SettingsItem] = [
    SettingsItem(type: .privacySecurity, icon: "hand.raised.fill", color: .blue, destination: AnyView(PrivacySecurityView()))
]

/// Services Settings
@MainActor
let serviceSettings: [SettingsItem] = [
    SettingsItem(type: .gameCenter, icon: "appleGameCenter", destination: AnyView(GameCenterView())),
    SettingsItem(type: .icloud, icon: "iCloud", destination: AnyView(EmptyView())),
    SettingsItem(type: .wallet, icon: "appleWallet", destination: AnyView(WalletView()))
]

/// Simulator Service Settings
@MainActor
let simulatorServiceSettings: [SettingsItem] = [
    SettingsItem(type: .gameCenter, icon: "Placeholder", color: .white, destination: AnyView(GameCenterView())),
    SettingsItem(type: .icloud, icon: "iCloudSimulator", destination: AnyView(EmptyView())),
    SettingsItem(type: .wallet, icon: "appleWallet", destination: AnyView(WalletView()))
]

/// App Settings
@MainActor
let appsSettings: [SettingsItem] = [
    SettingsItem(type: .apps, icon: "app.grid.3x3", color: .indigo, destination: AnyView(AppsView()))
]

/// Developer Settings
@MainActor
let developerSettings: [SettingsItem] = [
    SettingsItem(type: .developer, icon: "hammer.fill", color: .gray, destination: AnyView(BundleControllerView("DeveloperSettings", controller: "DTSettings", title: "Developer"))),
    SettingsItem(type: .carrierSettings, icon: "phone.fill", capability: .isInternal, color: .blue, destination: AnyView(EmptyView())),
    SettingsItem(type: .internalSettings, icon: "gear", capability: .isInternal, color: .blue, destination: AnyView(EmptyView()))
]

/// Combined Settings
@MainActor
let combinedSettings = followUpSettings + radioSettings + attentionSettings + mainSettings + securitySettings + serviceSettings + appsSettings + developerSettings + simulatorMainSettings + simulatorSecuritySettings
