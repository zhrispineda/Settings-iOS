//
//  MGHelper.swift
//  Preferences
//

import Foundation
import os

class MGHelper {
    /// Returns the value of the given key.
    /// 
    /// - Parameter key: The key as a String
    /// - Returns: The value of the key as either a String value or nil
    static func read(key: String) -> String? {
        typealias MGKey = (@convention(c) (CFString) -> CFTypeRef?)
        var mgKey: MGKey?
        
        logger.info("Attempting to get value for key: \(key)")
        
        // Initialize libMobileGestalt.dylib
        guard let gestalt = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_LAZY) else {
            return nil
        }
        
        // Encode the key
        guard let key = CFStringCreateWithCString(nil, key, CFStringBuiltInEncodings.ASCII.rawValue) else {
            logger.error("Unable to encode key: \(key)")
            return nil
        }
        
        mgKey = unsafeBitCast(dlsym(gestalt, "MGCopyAnswer"), to: MGKey.self)
        
        // Attempt to get key's value
        guard let value = mgKey?(key) else {
            logger.error("Could not get value for key: \(key)")
            return nil
        }
        
        // Obtain type returned
        let typeID = CFGetTypeID(value)
        
        // Based on data type, return as a casted String
        switch typeID {
        case CFBooleanGetTypeID():
            return CFBooleanGetValue((value as! CFBoolean)) ? "true" : "false"
        case CFNumberGetTypeID():
            if let number = value as? NSNumber {
                return number.stringValue
            }
        case CFStringGetTypeID():
            return String(describing: value)
        case CFDictionaryGetTypeID():
            if let dict = value as? [String: Any] {
                return "\(dict)"
            }
        case CFDataGetTypeID():
            let data = value as! Data
            return data.map { String($0) }.joined(separator: " ")
        default:
            return nil
        }
        
        logger.error("Could not get typeID for key: \(key)")
        return nil
    }
}

// Global logger variable
let logger = Logger()
