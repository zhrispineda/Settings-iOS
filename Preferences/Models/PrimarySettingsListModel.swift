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
enum PrimarySettingsListItemIdentifier: String {
    case followUpItem = "FOLLOWUP_TITLE"
    case primaryAppleAccount = "Apple Account"
    case family = "Family"
    case airplaneMode = "Airplane Mode"
    case wifi = "Wi-Fi"
    case ethernet = "Ethernet"
    case bluetooth = "Bluetooth"
    case cellular = "Cellular"
    case personalHotspot = "Personal Hotspot"
    case vpn = "VPN"
    case classroom = "Classroom"
    case satellite = "Satellite"
    case notifications = "Notifications"
    case sounds = "Sounds"
    case focus = "Focus"
    case screenTime = "Screen Time"
    case general = "General"
    case controlCenter = "Control Center"
    case actionButton = "Action Button"
    case displayAndBrightness = "Display & Brightness"
    case homeScreen = "Home Screen & App Library"
    case multitaskingAndGestures = "Multitasking & Gestures"
    case accessibility = "Accessibility"
    case wallpaper = "Wallpaper"
    case standBy = "StandBy"
    case siri = "Siri"
    case sideButton = "Side Button"
    case search = "Search"
    case pencil = "Apple Pencil"
    case passcodeAndBiometrics = "Passcode"
    case sos = "Emergency SOS"
    case exposureNotifications = "Exposure Notifications"
    case battery = "Battery"
    case privacySecurity = "Privacy & Security"
    case walletAndApplePay = "Wallet"
    case paymentAndContactless = "Payment & Contactless"
    case classKit = "Class Progress"
    case camera = "Camera"
    case gameCenter = "Game Center"
    case iCloud = "iCloud"
    case developer = "Developer"
    case carrier = "Carrier Settings"
    case `internal` = "Internal Settings"
    case faceTimeDebugging = "FaceTime Debugging"
    case iMessageDebugging = "iMessage Debugging"
    case continuityDebugging = "Continuity Debugging"
    case accessoryDeveloper = "Accessory Developer"
    case apps = "Apps"
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
    var id: UUID
    var customTitle: String?
    let type: PrimarySettingsListItemIdentifier
    var title: String { customTitle ?? type.rawValue }
    let icon: String
    var capabilities: [Capabilities]
    var badgeCount: Int
    let destination: AnyView
    var kind: RowKind = .link
    
    init(
        customTitle: String? = nil,
        type: PrimarySettingsListItemIdentifier,
        icon: String = "",
        capabilities: [Capabilities] = [],
        badgeCount: Int = 0,
        destination: AnyView = AnyView(
            EmptyView()
        ),
        kind: RowKind = .link
    ) {
        self.id = UUID()
        self.customTitle = customTitle
        self.type = type
        self.icon = icon
        self.capabilities = capabilities
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
                type: .followUpItem,
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
                customTitle: "Apple Intelligence",
                type: .siri,
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
                type: .homeScreen,
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
                type: .standBy,
                icon: "com.apple.graphic-icon.standby",
                capabilities: [.phone],
                destination: AnyView(StandByView())
            ),
            SettingsItem(
                type: .wallpaper,
                icon: "com.apple.graphic-icon.wallpaper",
                capabilities: [.isPhysical],
                destination: AnyView(WallpaperView())
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
                customTitle: UIDevice.iPhone ? "Sounds & Haptics" : "Sounds",
                type: .sounds,
                icon: "com.apple.graphic-icon.sound",
                capabilities: [.isPhysical],
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
                customTitle: "Face ID & Passcode",
                type: .passcodeAndBiometrics,
                icon: "com.apple.graphic-icon.face-id",
                capabilities: [.faceID, .isPhysical],
                destination: AnyView(BiometricPasscodeView())
            ),
            SettingsItem(
                customTitle: "Touch ID & Passcode",
                type: .passcodeAndBiometrics,
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
                type: .sos,
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
                type: .iCloud,
                icon: "com.apple.application-icon.icloud",
                destination: AnyView(EmptyView())
            ),
            SettingsItem(
                type: .walletAndApplePay,
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
                destination: AnyView(DeveloperView())
            ),
            SettingsItem(
                type: .carrier,
                icon: "com.apple.graphic-icon.carrier-settings",
                capabilities: [.carrierInstall, .isInternal],
                destination: AnyView(CarrierSettingsView())
            ),
            SettingsItem(
                type: .`internal`,
                icon: "com.apple.graphic-icon.internal-settings",
                capabilities: [.isInternal],
                destination: AnyView(InternalSettingsView())
            ),
            SettingsItem(
                type: .faceTimeDebugging,
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
