//
//  UIDeviceExtensions.swift
//  Preferences
//
//  An extension on UIDevice to add a custom functions.
//

import SwiftUI

public extension UIDevice {
    // getDevice(identifier: String)
    // Returns marketing-name key answer. Uses CacheExtra["ArtworkTraits"]["ArtworkDeviceProductDescription"] as a fallback.
    static func getDevice(identifier: String) -> String {
        if let answer = MGHelper.read(key: "Z/dqyWS6OZTRy10UcmUAhw") { // marketing-name key
            return answer
        }
        
        // Fallback
        if let mobileGestalt = UIDevice.checkDevice() {
            let cacheExtra = mobileGestalt["CacheExtra"] as! [String : AnyObject]
            return cacheExtra["oPeik/9e8lQWMszEjbPzng"]?["ArtworkDeviceProductDescription"] as! String // ArtworkTraits key
        } else {
            return "Error"
        }
    }
    
    static let storageCapacity: String? = {
        var diskCapacity = String()
        var formatted = String()
        
        guard let answer = MGHelper.read(key: "uyejyEdaxNWSRQQwHmXz1A") else {
            print("Cannot get storage capacity")
            return "Error"
        }
        
        let cleanedString = answer.trimmingCharacters(in: CharacterSet(charactersIn: "[]"))
        let components = cleanedString.components(separatedBy: ", ")
        for (index, value) in components.enumerated() {
            if value.contains("TotalDiskCapacity") {
                diskCapacity = value.replacingOccurrences(of: " ", with: "")
                formatted = diskCapacity.components(separatedBy: [":"])[1]
                switch Int(formatted) {
                case 32000000000:
                    return "32 GB"
                case 64000000000:
                    return "64 GB"
                case 128000000000:
                    return "128 GB"
                case 256000000000:
                    return "256 GB"
                case 512000000000:
                    return "512 GB"
                case 1024000000000:
                    return "1 TB"
                case 2048000000000:
                    return "2 TB"
                default:
                    return nil
                }
            }
        }
        
        return nil
    }()
    
    // Returns the marketing name of the host device using either getDevice(identifier: String) or SIMULATOR_MODEL_IDENTIFIER.
    static let fullModel: String = {
        return UIDevice.IsSimulator ? getDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "N/A") : getDevice(identifier: identifier)
    }()
    
    // Returns the ProductType key answer if host is not a Simulator. Otherwise return SIMULATOR_MODEL_IDENTIFIER.
    static let identifier: String = {
        guard let answer = MGHelper.read(key: "h9jDsbgj7xIVeIQ8S3/X3Q") else { return "Unknown" } // ProductType key
        
        return ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] == nil ? answer : ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
    }()
    
    static let AlwaysCaptureDepthCapability: Bool = { // Always Capture Depth Info
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4":
            return true
        default:
            return false
        }
    }()
    
    static let CellularTelephonyCapability: Bool = { // Cellular Data
        if let mobileGestalt = UIDevice.checkDevice() {
            let cacheExtra = mobileGestalt["CacheExtra"] as! [String : AnyObject]
            return cacheExtra["pB5sZVvnp+QjZQtt2KfQvA"] != nil // BasebandChipset check
        }
        
        // Fallback
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
        case "iPhone14,2", "iPhone14,3", "iPhone14,4", "iPhone14,5", "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4":
            return true
        default:
            return false
        }
    }()
    
    static let HigherResolutionCinematicModeCapability: Bool = { // 4K Cinematic Mode
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4":
            return true
        default:
            return false
        }
    }()
    
    static let DeviceSupportsBatteryInformation: Bool = { // Charge Cycles
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4", "iPad14,8", "iPad14,9", "iPad14,10", "iPad14,11", "iPad16,3", "iPad16,5", "iPad16,6":
            return true
        default:
            return false
        }
    }()
    
    static let DeviceSupportsEnhancedMultitasking: Bool = { // Stage Manager
        if let answer = MGHelper.read(key: "qeaj75wk3HF4DwQ8qbIi7g") {
            return Bool(answer)!
        }
        
        // Fallback
        var identifier = UIDevice.identifier
        switch identifier {
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4", "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8", "iPad8,9", "iPad8,10", "iPad8,11", "iPad8,12", "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7", "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11", "iPad13,16", "iPad13,17", "iPad14,5", "iPad14,8", "iPad14,9", "iPad14,10", "iPad14,11", "iPad16,3", "iPad16,4", "iPad16,5", "iPad16,6":
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
        if let answer = MGHelper.read(key: "JwLB44/jEB8aFDpXQ16Tuw") { // 1 = true; 2 = false
            return answer == "1" ? true : false
        }
        
        // Fallback
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
        case "iPhone14,2", "iPhone14,3", "iPhone15,2", "iPhone15,3", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4":
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
        if let answer = MGHelper.read(key: "8olRm6C1xqr7AJGpLRnpSw") {
            return Bool(answer)!
        }
        
        // Fallback
        var identifier = UIDevice.identifier
        switch identifier {
        case "iPhone12,8", "iPhone14,6", "iPad7,11", "iPad7,12", "iPad11,1", "iPad11,2", "iPad11,3", "iPad11,4", "iPad11,6", "iPad11,7", "iPad12,1", "iPad12,2", "iPad13,1", "iPad13,2", "iPad13,16", "iPad13,17", "iPad14,8", "iPad14,9", "iPad14,10", "iPad14,11":
            return false
        default:
            return true
            
        }
    }()

    static let ActionModeCapability = { // Action Mode
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4":
            return true
        default:
            return false
        }
    }()
    
    static let AdvancedPhotographicStylesCapability = { // Advanced Photographic Styles
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4":
            return true
        default:
            return false
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
        var identifier = UIDevice.fullModel
        
        return identifier.contains("Pro")
    }()
    
    static let RingerButtonCapability: Bool = { // Action Button
        var identifier = UIDevice.fullModel
        return identifier.contains("15 Pro") || identifier.contains("16")
    }()
    
    static let IsSimulator: Bool = {
        if let answer = MGHelper.read(key: "ulMliLomP737aAOJ/w/evA") {
            return Bool(answer)! && !Configuration().forcePhysical
        }
        
        // Fallback
        return ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] != nil && !Configuration().forcePhysical
    }()
    
    static let AlwaysOnDisplayCapability: Bool = { // Always On Display
        if let answer = MGHelper.read(key: "2OOJf1VhaM7NxfRok3HbWQ") {
            return Bool(answer)!
        }
        
        // Fallback
        var identifier = UIDevice.identifier
        switch identifier {
        case "iPhone15,2", "iPhone15,3", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2":
            return true
        default:
            return false
        }
    }()
    
    static let NightModeCapability: Bool = { // Night Mode
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone11,2", "iPhone11,4", "iPhone11,6", "iPhone11,8", "iPhone12,8", "iPhone14,6":
            return false
        default:
            return true
        }
    }()
    
    static let RearFacingCameraHDRCapability: Bool = { // HDR Video
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4", "iPhone14,2", "iPhone14,3", "iPhone14,4", "iPhone14,5", "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4":
            return true
        default:
            return false
        }
    }()
    
    static let SceneDetectionCapability: Bool = { // Scene Detection
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4":
            return true
        default:
            return false
        }
    }()
    
    static let ViewOutsideFrameCapability: Bool = { // Camera View Outside Frame
        var identifier = UIDevice.identifier
        
        switch identifier {
        case "iPhone11,8", "iPhone11,2", "iPhone11,6":
            return false
        default:
            return true
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
    
    static func checkDevice() -> [String: Any]? {
        let fileURL = URL(fileURLWithPath: "/private/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist")
        
        if FileManager.default.fileExists(atPath: fileURL.path) { // Physical device
            guard let dict = NSDictionary(contentsOf: fileURL) as? [String: Any] else {
                print("Failed to load file: \(fileURL.path)")
                return nil
            }
            return dict
        }
        return nil // Preview/Simulator
    }
}
