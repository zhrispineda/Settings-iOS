import SwiftUI
import FoundationModels

extension UIDevice {
    /// Checks if the device has an accessible MobileGestalt cache.
    /// - Returns: The contents of com.apple.MobileGestalt.plist as a dictionary.
    static func checkDevice() -> [String: Any]? {
        let fileURL = URL(fileURLWithPath: "/private/var/containers/Shared/SystemGroup/systemgroup.com.apple.mobilegestaltcache/Library/Caches/com.apple.MobileGestalt.plist")
        
        guard FileManager.default.fileExists(atPath: fileURL.path),
            let dict = NSDictionary(contentsOf: fileURL) as? [String: Any] else {
                return nil // Preview/Simulator instance
        }
        
        return dict // Physical device
    }
    
    /// A helper function to better simplify key responses that return `Bool` values.
    ///
    /// - Parameters:
    ///   - key: The key to query.
    ///   - fallback: The default value to fallback to. Set to false by default.
    ///
    /// - Returns: The `key`'s `Bool` response or `fallback`'s value if nil.
    private static func MGGetBoolAnswer(key: String, fallback: Bool = false) -> Bool {
        MGHelper.read(key: key).flatMap(Bool.init) ?? fallback
    }
    
    /// A helper function to better simplify key responses that return `String` values.
    ///
    /// - Parameters:
    ///   - key: The key to query.
    ///   - fallback: The default value to fallback to. Set to "" by default.
    ///
    /// - Returns: The `key`'s `String` response or `fallback`'s value if nil.
    private static func MGGetStringAnswer(key: String, fallback: String = "") -> String {
        MGHelper.read(key: key) ?? fallback
    }
    
    /// Returns the device storage capacity as an optional String. (e.g. "32 GB", "512 GB", "2 TB")
    static let storageCapacity: String? = {
        var diskCapacity = ""
        var formatted = ""
        
        guard let answer = MGHelper.read(key: "uyejyEdaxNWSRQQwHmXz1A") else { // DiskUsage key
            SettingsLogger.error("Could not get storage capacity information")
            return "Error"
        }
        
        let cleanedString = answer.trimmingCharacters(in: CharacterSet(charactersIn: "[]"))
        let components = cleanedString.components(separatedBy: ", ")
        for (index, value) in components.enumerated() {
            if value.contains("TotalDiskCapacity") {
                diskCapacity = value.replacing(" ", with: "")
                formatted = diskCapacity.components(separatedBy: [":"])[1]
                guard let byteCount = Int64(formatted) else { return nil }
                return byteCount.formatted(.byteCount(style: .file))
            }
        }
        
        return nil
    }()
    
    /// Returns the marketing-name value of the device.
    static let fullModel: String = {
        if let answer = MGHelper.read(key: "Z/dqyWS6OZTRy10UcmUAhw") { // Get value of marketing-name key
            return answer
        }
        
        // Fallback to ArtworkTraits key
        if let mobileGestalt = UIDevice.checkDevice() {
            let cacheExtra = mobileGestalt["CacheExtra"] as! [String : AnyObject]
            return cacheExtra["oPeik/9e8lQWMszEjbPzng"]?["ArtworkDeviceProductDescription"] as! String // ArtworkTraits key
        } else {
            SettingsLogger.error("Could not get marketing-name and ArtworkTraits key")
            return "Error"
        }
    }()

    /// Returns the ProductType value if the device is not a Simulator instance. Otherwise returns `SIMULATOR_MODEL_IDENTIFIER` value.
    static let identifier: String = {
        guard let answer = MGHelper.read(key: "h9jDsbgj7xIVeIQ8S3/X3Q") else { return "Unknown" } // ProductType key
        return ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] != nil ? ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]! : answer
    }()
    
    /// Returns a Bool on whether the device is capable of Always Capture Depth Information capability.
    static let AlwaysCaptureDepthCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4", "iPhone18,1", "iPhone18,2", "iPhone18,3", "iPhone18,4"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device is capable of cellular connectivity.
    static let CellularTelephonyCapability: Bool = {
        if let mobileGestalt = UIDevice.checkDevice() {
            let cacheExtra = mobileGestalt["CacheExtra"] as! [String : AnyObject]
            return cacheExtra["pB5sZVvnp+QjZQtt2KfQvA"] != nil // BasebandChipset check
        }
        
        // Fallback
        return UIDevice.iPhone || configuration.forceCellular
    }()
    
    /// Returns a Bool on whether the device is capable of Cinematic Mode.
    static let CinematicModeCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone14,2", "iPhone14,3", "iPhone14,4", "iPhone14,5", "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4", "iPhone17,5", "iPhone18,1", "iPhone18,2", "iPhone18,3", "iPhone18,4"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device is capable of 4K Cinematic Mode.
    static let HigherResolutionCinematicModeCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4", "iPhone17,5", "iPhone18,1", "iPhone18,2", "iPhone18,3", "iPhone18,4"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device is capable of Stage Manager.
    static let DeviceSupportsEnhancedMultitasking: Bool = {
        if let answer = MGHelper.read(key: "qeaj75wk3HF4DwQ8qbIi7g") { // DeviceSupportsEnhancedMultitasking key
            return Bool(answer)!
        }
        
        return false
    }()
    
    /// Returns a Bool on whether the device is an iPad.
    static let iPad: Bool = {
        return identifier.contains("iPad")
    }()
    
    /// Returns a Bool on whether the device is an iPhone.
    static let iPhone: Bool = {
        return identifier.contains("iPhone")
    }()
    
    /// Returns a Bool on whether the device is capable of Apple Intelligence.
    ///
    /// This uses FoundationModels as an easy public way to check for Apple Intelligence availability.
    /// - Important: When using preview, the availability will match the host Mac regardless of the simulated device's intelligence capability.
    static let IntelligenceCapability: Bool = {
        var model = SystemLanguageModel.default
        switch model.availability {
        case .available, .unavailable(.appleIntelligenceNotEnabled), .unavailable(.modelNotReady):
            return true
        default:
            return false
        }
    }()
    
    /// Returns a Bool on whether the device has a Home Button.
    static let HomeButtonCapability: Bool = {
        if let answer = MGHelper.read(key: "JwLB44/jEB8aFDpXQ16Tuw") { // HomeButtonType key
            return answer == "1" ? true : false // 1 = true; 2 = false
        }
        
        // Fallback
        let capableDevices: Set<String> = ["iPhone12,8", "iPhone14,6", "iPad11,3", "iPad11,1", "iPad11,2", "iPad11,6", "iPad11,7", "iPad12,1", "iPad12,2"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device has a LiDAR sensor.
    static let LiDARCapability: Bool = {
        let incapableDevices: Set<String> = ["iPhone12,3", "iPhone12,5", "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4", "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"]
        return !incapableDevices.contains(identifier) && UIDevice.ProDevice
    }()
    
    /// Returns a Bool on whether the device has Lens Correction available but only for the front camera.
    static let LimitedLensCorrectionCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone17,5", "iPad13,1", "iPad13,2", "iPad13,16", "iPad13,17", "iPad14,1", "iPad14,2", "iPad14,8", "iPad14,9", "iPad14,10", "iPad14,11", "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4", "iPad16,1", "iPad16,2"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device is capable of Lens Correction.
    /// iPhone: https://support.apple.com/guide/iphone/aside/iph4ecb9a67f
    /// iPad: https://support.apple.com/guide/ipad/aside/ipad71aac361
    static let LensCorrectionCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone12,8", "iPhone14,6", "iPhone17,5", "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4", "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8", "iPad8,9", "iPad8,10", "iPad8,11", "iPad8,12", "iPad11,1", "iPad11,2", "iPad11,3", "iPad11,4", "iPad11,6", "iPad11,7", "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7", "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11", "iPad14,3", "iPad14,4", "iPad14,5", "iPad14,6", "iPad15,3", "iPad15,4", "iPad15,5", "iPad15,6", "iPad16,3", "iPad16,4", "iPad16,5", "iPad16,6", "iPad17,1", "iPad17,2", "iPad17,3", "iPad17,4"]
        return !capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device has Macro Lens capability.
    static let MacroLensCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone14,2", "iPhone14,3", "iPhone15,2", "iPhone15,3", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4", "iPhone18,1", "iPhone18,2", "iPhone18,3"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device has a narrow notch. (iPhone 13, 13 mini, 13 Pro, 13 Pro Max, 14, 14 Plus, 16e)
    static let NarrowNotch = {
        let capableDevices: Set<String> = ["iPhone14,2", "iPhone14,3", "iPhone14,4", "iPhone14,5", "iPhone14,7", "iPhone14,8", "iPhone17,5"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device is capable of Action Mode.
    static let ActionModeCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4", "iPhone18,1", "iPhone18,2", "iPhone18,3", "iPhone18,4"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device is capable of Advanced Photographic Styles.
    static let AdvancedPhotographicStylesCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4", "iPhone18,1", "iPhone18,2", "iPhone18,3", "iPhone18,4"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device is capable of Photographic Styles.
    static let PhotographicStylesCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone14,2", "iPhone14,3", "iPhone14,4", "iPhone14,5", "iPhone14,6", "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,5"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device is a Pro model.
    static let ProDevice: Bool = {
        return fullModel.contains("Pro")
    }()
    
    /// Returns a Bool on whether the device is capable of Reference Mode.
    static let ReferenceModeCapability: Bool = {
        let capableDevices: Set<String> = ["iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11", "iPad14,5", "iPad14,6", "iPad16,3", "iPad16,4", "iPad16,5", "iPad16,6", "iPad17,1", "iPad17,2", "iPad17,3", "iPad17,4"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the host is a Simulator instance.
    static let IsSimulator: Bool = {
        if let answer = MGHelper.read(key: "ulMliLomP737aAOJ/w/evA") { // IsSimulator key
            return Bool(answer)! && !configuration.forcePhysical
        }
        
        // Fallback
        return ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] != nil && !configuration.forcePhysical
    }()

    /// Returns a Bool on whether the host is on a simulator/Mac.
    static let IsSimulated: Bool = {
        if let answer = MGHelper.read(key: "ulMliLomP737aAOJ/w/evA") { // IsSimulator key
            return Bool(answer)!
        }

        // Fallback
        return ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] != nil && !configuration.forcePhysical
    }()
    
    /// Returns a Bool on whether the device is capable of HDR capture.
    static let RearFacingCameraHDRCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4", "iPhone14,2", "iPhone14,3", "iPhone14,4", "iPhone14,5", "iPhone14,7", "iPhone14,8", "iPhone15,2", "iPhone15,3", "iPhone15,4", "iPhone15,5", "iPhone16,1", "iPhone16,2", "iPhone17,1", "iPhone17,2", "iPhone17,3", "iPhone17,4", "iPhone18,1", "iPhone18,2", "iPhone18,3", "iPhone18,4"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device is capable of Scene Detection.
    static let SceneDetectionCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone13,1", "iPhone13,2", "iPhone13,3", "iPhone13,4"]
        return capableDevices.contains(identifier)
    }()
    
    /// Returns a Bool on whether the device is capable of displaying the camera view outside of the frame in the Camera app.
    static let ViewOutsideFrameCapability: Bool = {
        let capableDevices: Set<String> = ["iPhone12,8", "iPhone14,6"]
        return !capableDevices.contains(identifier)
    }()
    
    // MARK: - Keys
    
    /// A Boolean value that indicates whether the device is on an internal install.
    static let `apple-internal-install` = MGGetBoolAnswer(key: "EqrsVvjcYDdxHBiQmGhAWw")
    
    /// The current build of the operating system.
    static let buildVersion = MGGetStringAnswer(key: "mZfUC7qo4pURNhyMHZ62RQ")
    
    /// A Boolean value that indicates whether the device has camera restrictions.
    static let cameraRestriction = MGGetBoolAnswer(key: "2pxKjejpRGpWvUE+3yp5mQ")
    
    /// A Boolean value that indicates whether the device supports Always On Display.
    static let DeviceSupportsAlwaysOnTime = MGGetBoolAnswer(key: "j8/Omm6s1lsmTDFsXjsBfA")
    
    /// A Boolean value that indicates whether the device is managed by an organization.
    static let isSupervised = false
    
    /// A Boolean value that indicates whether the device supports a Hall effect sensor.
    static let `hall-effect-sensor` = MGGetBoolAnswer(key: "Pop5T2XQdDA60MRyxQJdQ")
    
    /// A Boolean value that indicates whether the device supports HDR image capture.
    static let `hdr-image-capture` = MGGetBoolAnswer(key: "fh6DnnDGDVZ5kZ9nYn/GrQ")
    
    /// A Boolean value that indicates whether the device supports Face ID.
    static let PearlIDCapability = MGGetBoolAnswer(key: "8olRm6C1xqr7AJGpLRnpSw")
    
    /// A Boolean value that indicates whether the device is a security research device.
    static let ResearchFuse = MGGetBoolAnswer(key: "XYlJKKkj2hztRP1NWWnhlw")
    
    /// A Boolean value that indicates whether the device has an Action Button.
    static let RingerButtonCapability = MGGetBoolAnswer(key: "cT44WE1EohiwRzhsZ8xEsw")
    
    // MARK: - Paths
    static let RuntimePath = UIDevice.IsSimulated
        ? "/Library/Developer/CoreSimulator/Volumes/iOS_\(UIDevice.buildVersion)/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS \(UIDevice.current.systemVersion).simruntime/Contents/Resources/RuntimeRoot"
        : ""
}
