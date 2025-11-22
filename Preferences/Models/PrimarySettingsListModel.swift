/*
Abstract:
A combination of structs, enums, and classes to define the structure of the app.
*/

import SwiftUI
import Network

// MARK: - Global variables
/// Global variables for access across views. (forceCellular, forcePhysical, developerMode)
struct Configuration {
    let forceCellular = false
    let forcePhysical = true
    let developerMode = true
}

let configuration = Configuration()

final class RouteRegistry {
    @MainActor static let shared = RouteRegistry()
    private var registry: [String: () -> AnyView] = [:]
    
    func register(_ path: String, builder: @escaping () -> AnyView) {
        registry[path] = builder
    }
    
    func register<V: View>(_ path: String, builder: @escaping () -> V) {
        registry[path] = { AnyView(builder()) }
    }
    
    func view(for path: String) -> AnyView? {
        registry[path]?()
    }
}

// MARK: - PrimarySettingsListModel data
/// Stores the title of each enum variable for use in navigation.
enum SettingsOptions: String, CaseIterable {
    case accessibility = "Accessibility"
    case accessoryDeveloper = "Accessory Developer"
    case actionButton = "Action Button"
    case airplaneMode = "Airplane Mode"
    case appleIntelligence = "Apple Intelligence & Siri"
    case pencil = "Apple Pencil"
    case apps = "Apps"
    case battery = "Battery"
    case faceIDPasscode = "Face ID & Passcode"
    case bluetooth = "Bluetooth"
    case camera = "Camera"
    case carrierSettings = "Carrier Settings"
    case cellular = "Cellular"
    case continuityDebugging = "Continuity Debugging"
    case controlCenter = "Control Center"
    case developer = "Developer"
    case displayAndBrightness = "Display & Brightness"
    case emergencySOS = "Emergency SOS"
    case ethernet = "Ethernet"
    case facetimeDebugging = "FaceTime Debugging"
    case focus = "Focus"
    case followUp = "FOLLOWUP_TITLE"
    case gameCenter = "Game Center"
    case general = "General"
    case homeScreenAppLibrary = "Home Screen & App Library"
    case icloud = "iCloud"
    case iMessageDebugging = "iMessage Debugging"
    case internalSettings = "Internal Settings"
    case multitaskingAndGestures = "Multitasking & Gestures"
    case notifications = "Notifications"
    case passcodeAndBiometrics = "Passcode"
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
    case vpn = "VPN"
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
    case hotspot
    case vpn
    case phone
    case tablet
    case satellite
    case siri
    case sounds
    case soundsHaptics
    case touchID
    case appleIntelligence
    case carrierInstall
    case isInternal
    case isPhysical
    case isSimulator
    case developerMode
    case faceTimeDebugging
    case iMessageDebugging
    case continuityDebugging
    case accessoryDeveloper
}

enum RowKind: Hashable {
    case link
    case toggle(key: String)
}

/// A struct for defining custom navigation links for use with sections of the app.
struct SettingsItem: Identifiable, Hashable {
    var id: SettingsOptions { type }
    let type: SettingsOptions
    var title: String { type.rawValue }
    let icon: String
    var capabilities: [Capabilities]
    var color: Color
    var badgeCount: Int
    let destination: AnyView
    var kind: RowKind = .link
    
    init(
        type: SettingsOptions,
        icon: String = "",
        capabilities: [Capabilities] = [],
        color: Color = .white,
        badgeCount: Int = 0,
        destination: AnyView = AnyView(
            EmptyView()
        ),
        kind: RowKind = .link
    ) {
        self.type = type
        self.icon = icon
        self.capabilities = capabilities
        self.color = color
        self.badgeCount = badgeCount
        self.destination = destination
        self.kind = kind
    }
    
    static func == (lhs: SettingsItem, rhs: SettingsItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - State Manager
/// Class for managing the state of the app's NavigationStack selection variable and destination view.
@MainActor
@Observable
final class PrimarySettingsListModel {
    static let shared = PrimarySettingsListModel()
    var path: [String] = []
    var selection: SettingsItem? = nil
    var isCompact = false
    var showingDebugMenu = false
    var showingDebugOverlays = false
    var showingFaceTimeDebugging = false
    var showingMessageDebugging = false
    var showingContinuityDebugging = false
    var showingAccessoryDeveloper = false
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .userInitiated)
    private(set) var isConnected: Bool = false
    
    let followUpSettings: [SettingsItem]
    let radioSettings: [SettingsItem]
    let mainSettings: [SettingsItem]
    let attentionSettings: [SettingsItem]
    let securitySettings: [SettingsItem]
    let serviceSettings: [SettingsItem]
    let appsSettings: [SettingsItem]
    let developerSettings: [SettingsItem]

    init() {
        followUpSettings = [
            SettingsItem(
                type: .followUp,
                capabilities: [.isPhysical],
                badgeCount: 1,
                destination: AnyView(FollowUpView())
            )
        ]
        
        radioSettings = [
            SettingsItem(
                type: .airplaneMode,
                icon: "com.apple.graphic-icon.airplane-mode",
                capabilities: [.isPhysical],
                kind: .toggle(key: "AirplaneMode")
            ),
            SettingsItem(
                type: .wifi,
                icon: "com.apple.graphic-icon.wifi",
                capabilities: [.isPhysical],
                destination: AnyView(NetworkView())
            ),
            SettingsItem(
                type: .ethernet,
                icon: "com.apple.graphic-icon.ethernet",
                capabilities: [.ethernet],
                destination: AnyView(EmptyView())
            ),
            SettingsItem(
                type: .bluetooth,
                icon: "com.apple.graphic-icon.bluetooth",
                capabilities: [.isPhysical],
                destination: AnyView(BluetoothView())
            ),
            SettingsItem(
                type: .cellular,
                icon: "com.apple.graphic-icon.cellular-settings",
                capabilities: [.cellular, .isPhysical],
                destination: AnyView(CellularView())
            ),
            SettingsItem(
                type: .personalHotspot,
                icon: "com.apple.graphic-icon.personal-hotspot",
                capabilities: [.hotspot, .isPhysical],
                destination: AnyView(HotspotView())
            ),
            SettingsItem(
                type: .battery,
                icon: "com.apple.graphic-icon.battery",
                capabilities: [.isPhysical],
                destination: AnyView(BatteryView())
            ),
            SettingsItem(
                type: .satellite,
                icon: "com.apple.graphic-icon.satellite",
                capabilities: [.satellite],
                destination: AnyView(EmptyView())
            ),
            SettingsItem(
                type: .vpn,
                icon: "com.apple.graphic-icon.vpn",
                capabilities: [.vpn],
                kind: .toggle(key: "VPN")
            )
        ]
        
        mainSettings = [
            SettingsItem(
                type: .general,
                icon: "com.apple.graphic-icon.gear",
                destination: AnyView(GeneralView())
            ),
            SettingsItem(
                type: .accessibility,
                icon: "com.apple.graphic-icon.accessibility",
                destination: AnyView(AccessibilityView())
            ),
            SettingsItem(
                type: .actionButton,
                icon: "com.apple.graphic-icon.iphone-action-button",
                capabilities: [.actionButton],
                destination: AnyView(ActionButtonView())
            ),
            SettingsItem(
                type: .pencil,
                icon: "com.apple.graphic-icon.pencil",
                capabilities: [.tablet],
                destination: AnyView(ApplePencilView())
            ),
            SettingsItem(
                type: .appleIntelligence,
                icon: "com.apple.graphic-icon.intelligence",
                capabilities: [.appleIntelligence],
                destination: AnyView(SiriView())
            ),
            SettingsItem(
                type: .camera,
                icon: "com.apple.graphic-icon.camera",
                destination: AnyView(CameraView())
            ),
            SettingsItem(
                type: .controlCenter,
                icon: "com.apple.graphic-icon.control-center",
                capabilities: [.isPhysical],
                destination: AnyView(ControlCenterView())
            ),
            SettingsItem(
                type: .displayAndBrightness,
                icon: "com.apple.graphic-icon.display",
                capabilities: [.isPhysical],
                destination: AnyView(DisplayBrightnessView())
            ),
            SettingsItem(
                type: .homeScreenAppLibrary,
                icon: UIDevice.iPhone ? "com.apple.graphic-icon.apps-on-iphone" : "com.apple.graphic-icon.apps-on-ipad",
                destination: AnyView(HomeScreenAppLibraryView())
            ),
            SettingsItem(
                type: .multitaskingAndGestures,
                icon: "com.apple.graphic-icon.stage-manager",
                capabilities: [.tablet],
                destination: AnyView(MultitaskingAndGesturesView())
            ),
            SettingsItem(
                type: .search,
                icon: "com.apple.graphic-icon.search",
                destination: AnyView(SearchView())
            ),
            SettingsItem(
                type: .siri,
                icon: "com.apple.application-icon.siri",
                capabilities: [.siri],
                destination: AnyView(SiriView())
            ),
            SettingsItem(
                type: .standby,
                icon: "com.apple.graphic-icon.standby",
                capabilities: [.phone],
                destination: AnyView(StandByView())
            ),
            SettingsItem(
                type: .wallpaper,
                icon: "com.apple.graphic-icon.wallpaper",
                capabilities: [.isPhysical],
                destination: AnyView(BundleControllerView(
                        "WallpaperSettings",
                        controller: "WallpaperSettingsRootViewController"
                    ))
            ),
        ]
        
        attentionSettings = [
            SettingsItem(
                type: .notifications,
                icon: "com.apple.graphic-icon.notifications",
                capabilities: [.isPhysical],
                destination: AnyView(NotificationsView())
            ),
            SettingsItem(
                type: .sounds,
                icon: "com.apple.graphic-icon.sound",
                capabilities: [.sounds, .isPhysical],
                destination: AnyView(SoundsAndHapticsView())
            ),
            SettingsItem(
                type: .soundsHaptics,
                icon: "com.apple.graphic-icon.sound",
                capabilities: [.soundsHaptics, .isPhysical],
                destination: AnyView(SoundsAndHapticsView())
            ),
            SettingsItem(
                type: .focus,
                icon: "com.apple.graphic-icon.focus",
                capabilities: [.isPhysical],
                destination: AnyView(FocusView())
            ),
            SettingsItem(
                type: .screenTime,
                icon: "com.apple.graphic-icon.screen-time",
                destination: AnyView(ScreenTimeView())
            ),
        ]
        
        securitySettings = [
            SettingsItem(
                type: .faceIDPasscode,
                icon: "com.apple.graphic-icon.face-id",
                capabilities: [.faceID, .isPhysical],
                destination: AnyView(BiometricPasscodeView())
            ),
            SettingsItem(
                type: .touchIDPasscode,
                icon: "com.apple.graphic-icon.touch-id",
                capabilities: [.touchID, .isPhysical],
                destination: AnyView(BiometricPasscodeView())
            ),
            SettingsItem(
                type: .passcodeAndBiometrics,
                icon: "com.apple.graphic-icon.passcode",
                capabilities: [.isSimulator],
                destination: AnyView(EmptyView())
            ),
            SettingsItem(
                type: .emergencySOS,
                icon: "com.apple.graphic-icon.emergency-sos",
                capabilities: [.phone, .isPhysical],
                destination: AnyView(EmergencySOSView())
            ),
            SettingsItem(
                type: .privacySecurity,
                icon: "com.apple.graphic-icon.privacy",
                destination: AnyView(PrivacySecurityView())
            )
        ]
        
        serviceSettings = [
            SettingsItem(
                type: .gameCenter,
                icon: "com.apple.gamecenter.bubbles",
                destination: AnyView(GameCenterView())
            ),
            SettingsItem(
                type: .icloud,
                icon: "com.apple.application-icon.icloud",
                destination: AnyView(EmptyView())
            ),
            SettingsItem(
                type: .wallet,
                icon: "com.apple.Passbook",
                capabilities: [.isPhysical],
                destination: AnyView(WalletView())
            )
        ]
        
        appsSettings = [
            SettingsItem(
                type: .apps,
                icon: "com.apple.graphic-icon.home-screen",
                destination: AnyView(AppsView())
            )
        ]
        
        developerSettings = [
            SettingsItem(
                type: .developer,
                icon: "com.apple.graphic-icon.developer-tools",
                destination: AnyView(BundleControllerView(
                        "DeveloperSettings",
                        controller: "DTSettings",
                        title: "Developer"
                    ))
            ),
            SettingsItem(
                type: .carrierSettings,
                icon: "com.apple.graphic-icon.carrier-settings",
                capabilities: [.carrierInstall, .isInternal],
                destination: AnyView(CarrierSettingsView())
            ),
            SettingsItem(
                type: .internalSettings,
                icon: "com.apple.graphic-icon.internal-settings",
                capabilities: [.isInternal],
                destination: AnyView(InternalSettingsView())
            ),
            SettingsItem(
                type: .facetimeDebugging,
                icon: "com.apple.graphic-icon.tap-to-radar",
                capabilities: [.faceTimeDebugging],
                destination: AnyView(FaceTimeDebuggingView())
            ),
            SettingsItem(
                type: .iMessageDebugging,
                icon: "com.apple.graphic-icon.tap-to-radar",
                capabilities: [.iMessageDebugging],
                destination: AnyView(iMessageDebuggingView())
            ),
            SettingsItem(
                type: .continuityDebugging,
                icon: "com.apple.graphic-icon.tap-to-radar",
                capabilities: [.continuityDebugging],
                destination: AnyView(ContinuityDebuggingView())
            ),
            SettingsItem(
                type: .accessoryDeveloper,
                icon: "com.apple.graphic-icon.tap-to-radar",
                capabilities: [.accessoryDeveloper],
                destination: AnyView(AccessoryDeveloperView())
            )
        ]
        
        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
