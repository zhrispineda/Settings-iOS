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
@MainActor
@Observable final class StateManager {
    var path: NavigationPath = NavigationPath()
    var selection: SettingsItem? = nil
    
    /// Device-restricted views
    let phoneOnly: Set<String> = ["Action Button", "Emergency SOS", "Health", "Personal Hotspot", "StandBy"]
    let tabletOnly: Set<String> = ["Apple Pencil", "Multitasking & Gestures"]
    let followUpSettings: [SettingsItem]
    let radioSettings: [SettingsItem]
    let attentionSettings: [SettingsItem]
    let attentionSimulatorSettings: [SettingsItem]
    let mainSettings: [SettingsItem]
    let simulatorMainSettings: [SettingsItem]
    let securitySettings: [SettingsItem]
    let simulatorSecuritySettings: [SettingsItem]
    let serviceSettings: [SettingsItem]
    let simulatorServicesSettings: [SettingsItem]
    let appsSettings: [SettingsItem]
    let developerSettings: [SettingsItem]

    init() {
        followUpSettings = [
            SettingsItem(
                type: .followUp,
                icon: "None",
                destination: AnyView(
                    FollowUpView()
                )
            )
        ]
        
        radioSettings = [
            SettingsItem(
                type: .wifi,
                icon: "com.apple.graphic-icon.wifi",
                destination: AnyView(
                    NetworkView()
                )
            ),
            SettingsItem(
                type: .ethernet,
                icon: "com.apple.graphic-icon.ethernet",
                capability: .ethernet,
                destination: AnyView(
                    EmptyView()
                )
            ),
            SettingsItem(
                type: .bluetooth,
                icon: "com.apple.graphic-icon.bluetooth",
                destination: AnyView(
                    BluetoothView()
                )
            ),
            SettingsItem(
                type: .cellular,
                icon: "com.apple.graphic-icon.cellular-settings",
                capability: .cellular,
                destination: AnyView(
                    CellularView()
                )
            ),
            //SettingsItem(type: .personalHotspot, icon: "com.apple.graphic-icon.personal-hotspot", capability: .cellular, destination: AnyView(HotspotView())),
            SettingsItem(
                type: .battery,
                icon: "com.apple.graphic-icon.battery",
                destination: AnyView(
                    BatteryView()
                )
            ),
            //SettingsItem(type: .satellite, icon: "com.apple.graphic-icon.satellite", destination: AnyView(EmptyView()))
        ]
        
        attentionSettings = [
            SettingsItem(
                type: .notifications,
                icon: "com.apple.graphic-icon.notifications",
                destination: AnyView(
                    NotificationsView()
                )
            ),
            SettingsItem(
                type: .sounds,
                icon: "com.apple.graphic-icon.sound",
                capability: .sounds,
                destination: AnyView(
                    BundleControllerView(
                        "/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework/SoundsAndHapticsSettings",
                        controller: "SHSSoundsPrefController",
                        title: "Sounds"
                    )
                )
            ),
            SettingsItem(
                type: .soundsHaptics,
                icon: "com.apple.graphic-icon.sound",
                capability: .soundsHaptics,
                destination: AnyView(
                    BundleControllerView(
                        "/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework/SoundsAndHapticsSettings",
                        controller: "SHSSoundsPrefController",
                        title: "Sounds & Haptics"
                    )
                )
            ),
            SettingsItem(
                type: .focus,
                icon: "com.apple.graphic-icon.focus",
                destination: AnyView(
                    FocusView()
                )
            ),
            SettingsItem(
                type: .screenTime,
                icon: "com.apple.graphic-icon.screen-time",
                destination: AnyView(
                    ScreenTimeView()
                )
            ),
        ]
        
        attentionSimulatorSettings = [
            SettingsItem(
                type: .screenTime,
                icon: "com.apple.graphic-icon.screen-time",
                destination: AnyView(
                    ScreenTimeView()
                )
            ),
        ]
        
        mainSettings = [
            SettingsItem(
                type: .general,
                icon: "com.apple.graphic-icon.gear",
                destination: AnyView(
                    GeneralView()
                )
            ),
            SettingsItem(
                type: .accessibility,
                icon: "com.apple.graphic-icon.accessibility",
                destination: AnyView(
                    AccessibilityView()
                )
            ),
            SettingsItem(
                type: .actionButton,
                icon: "com.apple.graphic-icon.iphone-action-button",
                capability: .actionButton,
                destination: AnyView(
                    BundleControllerView(
                        "ActionButtonSettings",
                        controller: "ActionButtonSettings"
                    )
                )
            ),
            SettingsItem(
                type: .applePencil,
                icon: "com.apple.graphic-icon.pencil",
                destination: AnyView(
                    ApplePencilView()
                )
            ),
            SettingsItem(
                type: .appleIntelligence,
                icon: "com.apple.graphic-icon.intelligence",
                capability: .appleIntelligence,
                destination: AnyView(
                    SiriView()
                )
            ),
            SettingsItem(
                type: .camera,
                icon: "com.apple.graphic-icon.camera",
                destination: AnyView(
                    CameraView()
                )
            ),
            SettingsItem(
                type: .controlCenter,
                icon: "com.apple.graphic-icon.control-center",
                destination: AnyView(
                    BundleControllerView(
                        "ControlCenterSettings",
                        controller: "ControlCenterSettingsViewController",
                        title: "Control Center"
                    )
                )
            ),
            SettingsItem(
                type: .displayBrightness,
                icon: "com.apple.graphic-icon.display",
                destination: AnyView(
                    DisplayBrightnessView()
                )
            ),
            SettingsItem(
                type: .homeScreenAppLibrary,
                icon: UIDevice.iPhone ? "com.apple.graphic-icon.apps-on-iphone" : "com.apple.graphic-icon.apps-on-ipad",
                destination: AnyView(
                    HomeScreenAppLibraryView()
                )
            ),
            SettingsItem(
                type: .multitaskGestures,
                icon: "com.apple.graphic-icon.stage-manager",
                destination: AnyView(
                    BundleControllerView(
                        "MultitaskingAndGesturesSettings",
                        controller: "MultitaskingAndGesturesSettings",
                        title: "Multitasking & Gestures"
                    )
                )
            ),
            SettingsItem(
                type: .search,
                icon: "com.apple.graphic-icon.search",
                destination: AnyView(
                    SearchView()
                )
            ),
            SettingsItem(
                type: .siri,
                icon: "com.apple.application-icon.siri",
                capability: .siri,
                destination: AnyView(
                    SiriView()
                )
            ),
            SettingsItem(
                type: .standby,
                icon: "com.apple.graphic-icon.standby",
                destination: AnyView(
                    StandByView()
                )
            ),
            SettingsItem(
                type: .wallpaper,
                icon: "com.apple.graphic-icon.wallpaper",
                destination: AnyView(
                    BundleControllerView(
                        "WallpaperSettings",
                        controller: "WallpaperSettingsRootViewController"
                    )
                )
            ),
        ]
        
        simulatorMainSettings = [
            SettingsItem(
                type: .general,
                icon: "com.apple.graphic-icon.gear",
                destination: AnyView(
                    GeneralView()
                )
            ),
            SettingsItem(
                type: .accessibility,
                icon: "com.apple.graphic-icon.accessibility",
                destination: AnyView(
                    AccessibilityView()
                )
            ),
            SettingsItem(
                type: .appleIntelligence,
                icon: "com.apple.graphic-icon.intelligence",
                destination: AnyView(
                    SiriView()
                )
            ),
            SettingsItem(
                type: .actionButton,
                icon: "com.apple.graphic-icon.iphone-action-button",
                capability: .actionButton,
                destination: AnyView(
                    BundleControllerView(
                        "ActionButtonSettings",
                        controller: "ActionButtonSettings"
                    )
                )
            ),
            SettingsItem(
                type: .camera,
                icon: "com.apple.graphic-icon.camera",
                destination: AnyView(
                    CameraView()
                )
            ),
            SettingsItem(
                type: .homeScreenAppLibrary,
                icon: UIDevice.iPhone ? "com.apple.graphic-icon.apps-on-iphone" : "com.apple.graphic-icon.apps-on-ipad",
                destination: AnyView(
                    HomeScreenAppLibraryView()
                )
            ),
            SettingsItem(
                type: .multitaskGestures,
                icon: "com.apple.graphic-icon.stage-manager",
                destination: AnyView(
                    BundleControllerView(
                        "MultitaskingAndGesturesSettings",
                        controller: "MultitaskingAndGesturesSettings",
                        title: "Multitasking & Gestures"
                    )
                )
            ),
            SettingsItem(
                type: .search,
                icon: "com.apple.graphic-icon.search",
                destination: AnyView(
                    SearchView()
                )
            ),
            SettingsItem(
                type: .siri,
                icon: "com.apple.graphic-icon.intelligence",
                capability: .siri,
                destination: AnyView(
                    SiriView()
                )
            ),
            SettingsItem(
                type: .standby,
                icon: "com.apple.graphic-icon.standby",
                destination: AnyView(
                    StandByView()
                )
            )
        ]
        
        securitySettings = [
            SettingsItem(
                type: .faceIDPasscode,
                icon: "com.apple.graphic-icon.face-id",
                capability: .faceID,
                destination: AnyView(
                    BiometricPasscodeView()
                )
            ),
            SettingsItem(
                type: .touchIDPasscode,
                icon: "com.apple.graphic-icon.touch-id",
                capability: .touchID,
                destination: AnyView(
                    BiometricPasscodeView()
                )
            ),
            SettingsItem(
                type: .emergencySOS,
                icon: "com.apple.graphic-icon.emergency-sos",
                destination: AnyView(
                    BundleControllerView(
                        "SOSSettings",
                        controller: "SOSSettingsController",
                        title: "Emergency SOS"
                    )
                )
            ),
            SettingsItem(
                type: .privacySecurity,
                icon: "com.apple.graphic-icon.privacy",
                destination: AnyView(
                    PrivacySecurityView()
                )
            )
        ]
        
        simulatorSecuritySettings = [
            SettingsItem(
                type: .privacySecurity,
                icon: "com.apple.graphic-icon.privacy",
                destination: AnyView(
                    PrivacySecurityView()
                )
            )
        ]
        
        serviceSettings = [
            SettingsItem(
                type: .gameCenter,
                icon: "com.apple.gamecenter.bubbles",
                destination: AnyView(
                    BundleControllerView(
                        "/System/Library/PrivateFrameworks/GameCenterUI.framework/GameCenterUI",
                        controller: "GameCenterUI.SettingsContainerViewController",
                        title: "Game Center"
                    )
                )
            ),
            SettingsItem(
                type: .icloud,
                icon: "com.apple.application-icon.icloud",
                destination: AnyView(
                    EmptyView()
                )
            ),
            SettingsItem(
                type: .wallet,
                icon: "com.apple.Passbook",
                destination: AnyView(
                    WalletView()
                )
            )
        ]
        
        simulatorServicesSettings = [
            SettingsItem(
                type: .gameCenter,
                icon: "com.apple.gamecenter.bubbles",
                destination: AnyView(
                    BundleControllerView(
                        "/System/Library/PrivateFrameworks/GameCenterUI.framework/GameCenterUI",
                        controller: "GameCenterUI.SettingsContainerViewController",
                        title: "Game Center"
                    )
                )
            ),
            SettingsItem(
                type: .icloud,
                icon: "com.apple.application-icon.icloud",
                destination: AnyView(
                    EmptyView()
                )
            )
        ]
        
        appsSettings = [
            SettingsItem(
                type: .apps,
                icon: "com.apple.graphic-icon.home-screen",
                destination: AnyView(
                    AppsView()
                )
            )
        ]
        
        developerSettings = [
            SettingsItem(
                type: .developer,
                icon: "com.apple.graphic-icon.developer-tools",
                destination: AnyView(
                    BundleControllerView(
                        "DeveloperSettings",
                        controller: "DTSettings",
                        title: "Developer"
                    )
                )
            ),
            SettingsItem(
                type: .carrierSettings,
                icon: "com.apple.graphic-icon.carrier-settings",
                capability: .isInternal,
                destination: AnyView(
                    EmptyView()
                )
            ),
            SettingsItem(
                type: .internalSettings,
                icon: "com.apple.graphic-icon.internal-settings",
                capability: .isInternal,
                destination: AnyView(
                    EmptyView()
                )
            )
        ]
    }
}

// MARK: - SettingsModel data
/// Stores the title of each enum variable for use in navigation.
enum SettingsOptions: String, CaseIterable {
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
struct SettingsItem: Identifiable, Hashable {
    var id: SettingsOptions { type }
    let type: SettingsOptions
    var title: String { type.rawValue }
    let icon: String
    var capability: Capabilities
    var color: Color
    let destination: AnyView
    
    init(type: SettingsOptions, icon: String, capability: Capabilities = .none, color: Color = .white, destination: AnyView) {
        self.type = type
        self.icon = icon
        self.capability = capability
        self.color = color
        self.destination = destination
    }
    
    static func == (lhs: SettingsItem, rhs: SettingsItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
