//
//  SettingsModel.swift
//  Preferences
//
//  Settings
//

import SwiftUI

// MARK: Global variables
struct Configuration {
    let forceCellular = false
    let forcePhysical = true
    let developerMode = true
}

// MARK: Color extension
extension Color {
    static subscript(name: String) -> Color {
        switch name {
        case "Label":
            return Color(UIColor.label)
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

// MARK: Device class; Simulator only
@MainActor
class Device: ObservableObject {
    @Published var model: String = UIDevice.current.localizedModel
    
    var isPhone = UIDevice.current.localizedModel == "iPhone"
    var isTablet = UIDevice.current.localizedModel == "iPad"
    var isPro = UIDevice.current.name.contains("Pro")
    var isLargestTablet = UIDevice.current.name.contains("12.9")
    var isStageManagerCapable = UIDevice.current.name.contains("Air (5th") || UIDevice.current.name.contains("M2") || UIDevice.current.name.contains("M4") || UIDevice.current.name.contains("Pro (11") || UIDevice.current.name.contains("(12.9-inch) (3") || UIDevice.current.name.contains("(12.9-inch) (4") || UIDevice.current.name.contains("(12.9-inch) (5") || UIDevice.current.name.contains("(12.9-inch) (6")
    var isCinematicCapable = UIDevice.current.name.contains("iPhone 13") || UIDevice.current.name.contains("14") || UIDevice.current.name.contains("15")
    var isPhotographicStylesCapable = UIDevice.current.name.contains("SE (3") || UIDevice.current.name.contains("iPhone 13") || UIDevice.current.name.contains("14") || UIDevice.current.name.contains("15")
    var isPortraitsPhotoModeCapable = UIDevice.current.name.contains("15")
    var isLensCorrectionCapable = !UIDevice.current.name.contains("SE")
    var hasHomeButton = UIDevice.current.name.contains("SE")
    var hasFaceAuth = !UIDevice.current.name.contains("SE") && !UIDevice.current.name.contains("Air") && !UIDevice.current.name.contains("iPad (") && !UIDevice.current.name.contains("iPad mini")
    var hasMacroLens = UIDevice.current.name.contains("13 Pro") || UIDevice.current.name.contains("14 Pro") || UIDevice.current.name.contains("15 Pro")
    var hasAlwaysOnDisplay = UIDevice.current.name.contains("14 Pro") || UIDevice.current.name.contains("15 Pro")
    var hasExtraBatteryFeatures = UIDevice.current.name.contains("15") || (UIDevice.current.name.contains("Air") && UIDevice.current.name.contains("M2")) || UIDevice.current.name.contains("M4")
    var hasActionButton = UIDevice.current.name.contains("15 Pro")
    
    var physicalModel = UIDevice.fullModel
}

// MARK: UIDevice extension for physical devices
public extension UIDevice {
    static let identifier: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] == "N/A" ? identifier : ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "N/A"
    }()
    
    static let fullModel: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        @MainActor func getDevice(identifier: String) -> String {
            switch identifier {
            // iPhone models
            case "iPhone12,8", "iPhone14,6":
                return "iPhone SE"
            case "iPhone 11,2":
                return "iPhone XS"
            case "iPhone 11,4", "iPhone 11,6":
                return "iPhone XS Max"
            case "iPhone11,8":
                return "iPhone XR"
                
            case "iPhone15,4":
                return "iPhone 15"
            case "iPhone15,5":
                return "iPhone 15 Plus"
            case "iPhone16,1":
                return "iPhone 15 Pro"
            case "iPhone16,2":
                return "iPhone 15 Pro Max"
                
            case "iPad14,1", "iPad14,2":
                return "iPad mini"
            case "iPad14,11":
                return "iPad Air 13-inch (M2)"
                
            case "iPad16,3", "iPad16,4":
                return "iPad Pro 11-inch (M4)"
            case "iPad16,5", "iPad16,6":
                return "iPad Pro 13-inch (M4)"
            case "N/A":
                return "N/A"
            case "arm64":
                return Configuration().forcePhysical ? getDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "N/A") : "Simulator"
            default:
                return identifier
            }
        }
        
        return UIDevice.isSimulator ? getDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "N/A") : getDevice(identifier: identifier)
    }()
    
    static let isCellularCapable: Bool = {
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPad7,12", "iPad8,3", "iPad8,4", "iPad8,7", "iPad8,8", "iPad8,10", "iPad8,12", "iPad11,2", "iPad11,4", "iPad11,7", "iPad12,2", "iPad13,5", "iPad13,6", "iPad13,7", "iPad13,9", "iPad 13,10", "iPad13,11", "iPad13,2", "iPad13,17", "iPad13,19", "iPad14,2", "iPad14,4", "iPad14,6", "iPad14,9", "iPad14,11", "iPad16,4", "iPad16,6":
            return true
        default:
            return identifier.contains("iPhone") || Configuration().forceCellular
        }
    }()
    
    static let isSimulator: Bool = {
        return ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] != nil && !Configuration().forcePhysical
    }()
}


// MARK: - SettingsModel data
enum SettingsModel: String, CaseIterable {
    case accessibility = "Accessibility"
    case actionButton = "Action Button"
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
    case multitaskGestures = "Multitasking & Gestures"
    case notifications = "Notifications"
    case personalHotspot = "Personal Hotspot"
    case privacySecurity = "Privacy & Security"
    case screenTime = "Screen Time"
    case search = "Search"
    case siri = "Siri"
    case soundHaptics = "Sound & Haptics"
    case standby = "StandBy"
    case wallet = "Wallet"
    case wallpaper = "Wallpaper"
    case wifi = "Wi-Fi"
}

struct SettingsItem<Content: View>: Identifiable {
    var id: String { title }
    let type: SettingsModel
    let title: String
    let icon: String
    var color: Color = Color(.gray)
    let destination: Content
}

// MARK: Icons information
let smallerIcons = ["apps.iphone", "apps.ipad", "bluetooth", "hand.raised.fill", "hourglass", "ipad.gen2", "iphone.gen3", "mic.fill", "shield.fill"]
let largerIcons = [""]
let hierarchyIcons = ["faceid", "questionmark.app.dashed", "questionmark.square.dashed"]
let internalIcons = ["airdrop", "apple.photos", "bluetooth", "carplay", "chevron.3.up.perspective", "clock.filled.and.widget.filled", "figure.run.motion", "iphone.action.button.arrow.right", "iphone.badge.dot.radiowaves.up.forward", "keyboard.badge.waveform.fill", "nearby.interactions", "network.connected.to.line.below", "pencil.and.sparkles", "sensorkit"]

// MARK: - Settings Layout
// MARK: Radio Settings
@MainActor let radioSettings: [SettingsItem] = [
    SettingsItem(type: .wifi, title: "Wi-Fi", icon: "wifi", color: .blue, destination: AnyView(NetworkView())),
    SettingsItem(type: .bluetooth, title: "Bluetooth", icon: "bluetooth", color: .blue, destination: AnyView(BluetoothView())),
    SettingsItem(type: .cellular, title: "Cellular", icon: "antenna.radiowaves.left.and.right", color: .green, destination: AnyView(CellularView())),
    SettingsItem(type: .personalHotspot, title: "Personal Hotspot", icon: "personalhotspot", color: .green, destination: AnyView(HotspotView())),
    SettingsItem(type: .battery, title: "Battery", icon: "battery.100percent", color: .green, destination: AnyView(BatteryView())),
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
    SettingsItem(type: .actionButton, title: "Action Button", icon: "iphone.action.button.arrow.right", color: .blue, destination: AnyView(ActionButtonView())),
    SettingsItem(type: .camera, title: "Camera", icon: "camera.fill", color: .gray, destination: AnyView(CameraView())),
    SettingsItem(type: .controlCenter, title: "Control Center", icon: "switch.2", destination: AnyView(ControlCenterView())),
    SettingsItem(type: .displayBrightness, title: "Display & Brightness", icon: "sun.max.fill", color: .blue, destination: AnyView(DisplayBrightnessView())),
    SettingsItem(type: .homeScreenAppLibrary, title: "Home Screen & App Library", icon: Device().isPhone ? "apps.iphone" : "apps.ipad", color: .blue, destination: AnyView(HomeScreenAppLibraryView())),
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
    SettingsItem(type: .actionButton, title: "Action Button", icon: "iphone.action.button.arrow.right", color: .blue, destination: AnyView(ActionButtonView())),
    SettingsItem(type: .camera, title: "Camera", icon: "camera.fill", color: .gray, destination: AnyView(CameraView())),
    SettingsItem(type: .homeScreenAppLibrary, title: "Home Screen & App Library", icon: "apps.iphone", color: .blue, destination: AnyView(HomeScreenAppLibraryView())),
    SettingsItem(type: .multitaskGestures, title: "Multitasking & Gestures", icon: "squares.leading.rectangle", color: .blue, destination: AnyView(MultitaskingGesturesView())),
    SettingsItem(type: .search, title: "Search", icon: "magnifyingglass", color: .gray, destination: AnyView(SearchView())),
    SettingsItem(type: .siri, title: "Siri", icon: "appleSiri", color: Color(UIColor.systemBackground), destination: AnyView(SiriView())),
    SettingsItem(type: .standby, title: "StandBy", icon: "clock.filled.and.widget.filled", color: .black, destination: AnyView(StandByView())),
]

// MARK: Security Settings
@MainActor let securitySettings: [SettingsItem] = [
    SettingsItem(type: .biometricPasscode, title: "\(Device().hasFaceAuth ? "Face" : "Touch") ID & Passcode", icon: Device().hasFaceAuth ? "faceid" : "lock.fill", color: Device().hasFaceAuth ? .green : .red, destination: AnyView(BiometricPasscodeView())),
    SettingsItem(type: .emergencySOS, title: "Emergency SOS", icon: "sos", color: .red, destination: AnyView(EmergencyView())),
    SettingsItem(type: .privacySecurity, title: "Privacy & Security", icon: "hand.raised.fill", color: .blue, destination: AnyView(PrivacySecurityView()))
]

// MARK: Simulator Security Settings
@MainActor let simulatorSecuritySettings: [SettingsItem] = [
    SettingsItem(type: .privacySecurity, title: "Privacy & Security", icon: "hand.raised.fill", color: .blue, destination: AnyView(PrivacySecurityView()))
]

// MARK: Services Settings
@MainActor let serviceSettings: [SettingsItem] = [
    SettingsItem(type: .appStore, title: "App Store", icon: UIDevice.isSimulator ? "Placeholder" : "appleAppStore", destination: UIDevice.isSimulator ? AnyView(EmptyView()) : AnyView(AppStoreView())),
    SettingsItem(type: .gameCenter, title: "Game Center", icon: UIDevice.isSimulator ? "Placeholder" : "appleGameCenter", destination: AnyView(GameCenterView())),
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
