//
//  MGHelper.swift
//  Preferences
//

import Foundation

class MGHelper {
    /// Returns the value of the given key.
    /// 
    /// - Parameter key: The key as a String
    /// - Returns: The value of the key as either a String value or nil
    static func read(key: String) -> String? {
        typealias MGKey = (@convention(c) (CFString) -> CFTypeRef?)
        var mgKey: MGKey?
        
        SettingsLogger.info("Attempting to get value for key: \(key)")
        
        // Initialize libMobileGestalt.dylib
        guard let gestalt = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_LAZY) else {
            return nil
        }
        
        // Encode the key
        guard let key = CFStringCreateWithCString(nil, key, CFStringBuiltInEncodings.ASCII.rawValue) else {
            SettingsLogger.error("Unable to encode key: \(key)")
            return nil
        }
        
        mgKey = unsafeBitCast(dlsym(gestalt, "MGCopyAnswer"), to: MGKey.self)
        
        // Attempt to get value from key
        guard let value = mgKey?(key) else {
            SettingsLogger.error("Could not get value for key: \(key)")
            return nil
        }
        
        let typeID = CFGetTypeID(value)
        
        // Based on data type, return as a casted String
        switch typeID {
        case CFBooleanGetTypeID():
            SettingsLogger.log("Found value for \(key): \(value)")
            return CFBooleanGetValue((value as! CFBoolean)) ? "true" : "false"
        case CFNumberGetTypeID():
            if let number = value as? NSNumber {
                SettingsLogger.info("Found value for \(key): \(value)")
                return number.stringValue
            }
        case CFStringGetTypeID():
            SettingsLogger.log("Found value for \(key): \(value)")
            return String(describing: value)
        case CFDictionaryGetTypeID():
            if let dict = value as? [String: Any] {
                SettingsLogger.log("Found value for \(key): \(value)")
                return "\(dict)"
            }
        case CFDataGetTypeID():
            let data = value as! Data
            SettingsLogger.log("Found value for \(key): \(value)")
            return data.map { String($0) }.joined(separator: " ")
        default:
            return nil
        }
        
        SettingsLogger.error("Could not get typeID for key: \(key)")
        
        return nil
    }
}
