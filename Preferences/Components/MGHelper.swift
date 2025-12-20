//
//  MGHelper.swift
//  Preferences
//

/// Contains helper functions for interacting with MobileGestalt, an internal system for device characteristics lookup.
///
/// - Warning: Do not use methods in this class for public applications. It is not publicly supported.
class MGHelper {
    /// Returns the value of a given key from MobileGestalt.
    ///
    /// - Parameter key: The key to query as a String.
    /// 
    /// - Returns: The value of the key as either a String value or nil.
    ///
    /// - Warning: Do not use this for public applications. It is not publicly supported.
    ///
    /// - Note: Some keys may be inaccessible due to missing entitlements.
    static func read(key: String) -> String? {
        typealias MGCopyAnswer = (@convention(c) (CFString) -> CFTypeRef?)
        var mgCopyAnswer: MGCopyAnswer?
        
        // Initialize
        guard let gestalt = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_LAZY) else {
            SettingsLogger.info("Could not interact with libMobileGestalt.dylib")
            return nil
        }
        
        // Prepare key for use with MGCopyAnswer
        guard let key = CFStringCreateWithCString(nil, key, CFStringBuiltInEncodings.ASCII.rawValue) else {
            SettingsLogger.error("Could not encode key: \(key)")
            return nil
        }
        
        mgCopyAnswer = unsafeBitCast(dlsym(gestalt, "MGCopyAnswer"), to: MGCopyAnswer.self)
        
        // Get answer through MGCopyAnswer
        guard let value = mgCopyAnswer?(key) else {
            SettingsLogger.error("Could not get answer for key: \(key)")
            return nil
        }
        
        let typeID = CFGetTypeID(value)
        
        // Return answer as a casted String
        switch typeID {
        case CFBooleanGetTypeID():
            let bool = value as! CFBoolean
            SettingsLogger.log("Found (Bool) value for \(key): \(value)")
            return CFBooleanGetValue(bool) ? "true" : "false"
        case CFNumberGetTypeID():
            if let number = value as? NSNumber {
                SettingsLogger.info("Found (Number) value for \(key): \(value)")
                return number.stringValue
            }
        case CFStringGetTypeID():
            SettingsLogger.log("Found (String) value for \(key): \(value)")
            return String(describing: value)
        case CFDictionaryGetTypeID():
            if let dict = value as? [String: Any] {
                SettingsLogger.log("Found (Dictionary) value for \(key): \(value)")
                return "\(dict)"
            }
        case CFDataGetTypeID():
            let data = value as! Data
            SettingsLogger.log("Found (Data) value for \(key): \(value)")
            return data.map { String($0) }.joined(separator: " ")
        default:
            SettingsLogger.error("Could not get TypeID for key: \(key)")
        }
        
        SettingsLogger.error("Could not get answer for key: \(key)")
        return nil
    }
}
