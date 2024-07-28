//
//  UIDeviceExtensions.swift
//  Preferences
//
//  An extension on UIDevice to add a custom functions.
//

import SwiftUI

public extension UIDevice {
    static let identifier: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] == nil ? identifier : ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "N/A"
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
    
    static let AlwaysCaptureDepthCapability: Bool = { // Always Capture Depth Info
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2":
            return true
        default:
            return false
        }
    }()
    
    static let CellularTelephonyCapability: Bool = { // Cellular Data
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPad7,12", "iPad8,3", "iPad8,4", "iPad8,7", "iPad8,8", "iPad8,10", "iPad8,12", "iPad11,2", "iPad11,4", "iPad11,7", "iPad12,2", "iPad13,5", "iPad13,6", "iPad13,7", "iPad13,9", "iPad 13,10", "iPad13,11", "iPad13,2", "iPad13,17", "iPad13,19", "iPad14,2", "iPad14,4", "iPad14,6", "iPad14,9", "iPad14,11", "iPad16,4", "iPad16,6":
            return true
        default:
            return identifier.contains("iPhone") || Configuration().forceCellular
        }
    }()
    
    static let CinematicModeCapability: Bool = { // Cinematic Mode
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone14,4", "iPhone14,5", "iPhone14,2", "iPhone14,3", "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2":
            return true
        default:
            return false
        }
    }()
    
    static let DeviceSupportsBatteryInformation: Bool = { // Charge Cycles
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPad14,8", "iPad14,9", "iPad14,10", "iPad14,11", "iPad16,3", "iPad16,5", "iPad16,6":
            return true
        default:
            return false
        }
    }()
    
    static let DeviceSupportsEnhancedMultitasking: Bool = {
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4", "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8", "iPad8,9", "iPad8,10", "iPad8,11", "iPad8,12", "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7", "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11", "iPad13,16", "iPad13,17", "iPad14,8", "iPad14,9", "iPad14,10", "iPad14,11":
            return true
        default:
            return false
        }
    }()
    
    static let iPad: Bool = {
        var identifier = UIDevice.identifier
        return identifier.contains("iPad")
    }()
    
    static let iPhone: Bool = {
        var identifier = UIDevice.identifier
        return identifier.contains("iPhone")
    }()
    
    static let HomeButtonCapability: Bool = { // Home Button
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone12,8", "iPhone14,6", "iPad11,3", "iPad7,11", "iPad7,12", "iPad11,1", "iPad11,2", "iPad11,6", "iPad11,7", "iPad12,1", "iPad12,2":
            return true
        default:
            return false
        }
    }()
    
    static let LargerSize: Bool = { // iPad 12.9/13 inch display
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8", "iPad8,11", "iPad8,12", "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11", "iPad14,10", "iPad14,11", "iPad16,5", "iPad16,6":
            return true
        default:
            return false
        }
    }()
    
    static let LensCorrectionCapability: Bool = { // Lens Correction
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone12,8", "iPhone14,6", "iPad7,11", "iPad7,12", "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4", "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8", "iPad8,9", "iPad8,10", "iPad8,11", "iPad8,12", "iPad11,1", "iPad11,2", "iPad11,3", "iPad11,4", "iPad11,6", "iPad11,7":
            return false
        default:
            return true
        }
    }()
    
    static let MacroLensCapability: Bool = { // Macro Lens
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone14,2", "iPhone14,3", "iPhone15,2", "iPhone15,3", "iPhone16,1", "iPhone16,2":
            return true
        default:
            return false
        }
    }()
    
    static let NarrowNotch = { // Narrow Notch (iPhone 13, 13 mini, 13 Pro, 13 Pro Max, 14, 14 Plus)
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone14,2", "iPhone14,3", "iPhone14,4", "iPhone14,5", "iPhone14,7", "iPhone14,8":
            return true
        default:
            return false
        }
    }()
    
    static let PearlIDCapability: Bool = { // Face ID
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone12,8", "iPhone14,6", "iPad7,11", "iPad7,12", "iPad11,1", "iPad11,2", "iPad11,3", "iPad11,4", "iPad11,6", "iPad11,7", "iPad12,1", "iPad12,2", "iPad13,1", "iPad13,2", "iPad13,16", "iPad13,17", "iPad14,8", "iPad14,9", "iPad14,10", "iPad14,11":
            return false
        default:
            return true
            
        }
    }()
    
    static let PhotographicStylesCapability = { // Photographic Styles
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone14,2", "iPhone14,3", "iPhone14,4", "iPhone14,5", "iPhone14,6", "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2":
            return true
        default:
            return false
        }
    }()
    
    static let ProDevice = {
        var identifier = UIDevice.identifier
        
        return identifier.contains("Pro")
    }()
    
    static let RingerButtonCapability: Bool = { // Action Button
        var identifier = UIDevice.fullModel
        return identifier.contains("15 Pro")
    }()
    
    static let isSimulator: Bool = {
        return ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] != nil && !Configuration().forcePhysical
    }()
    
    static let AlwaysOnDisplayCapability: Bool = { // Always On Display
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone15,2", "iPhone15,3", "iPhone16,1", "iPhone16,2":
            return true
        default:
            return false
        }
    }()
    
    static let WideNotch = { // Wide Notch (iPhone XR, XS, XS Max, 11, 11 Pro, 11 Pro Max, 12, 12 mini, 12 Pro, 12 Pro Max)
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone11,8", "iPhone11,2", "iPhone11,6", "iPhone11,4", "iPhone12,1", "iPhone12,3", "iPhone12,5", "iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4":
            return true
        default:
            return false
        }
    }()
}
