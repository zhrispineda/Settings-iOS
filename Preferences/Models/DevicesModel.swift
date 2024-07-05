//
//  RequiredCapabilities.swift
//  Preferences
//

import SwiftUI

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
