//
//  MGHelper.swift
//  Preferences
//
//  Class with functionality for reading MobileGestalt keys.
//

import Foundation
import os

class MGHelper {
    static func read(key: String) -> String? {
        typealias MGKey = (@convention(c) (CFString) -> CFTypeRef?)
        let logger = Logger()
        var mgKey: MGKey?
        
        logger.info("Attempting to find key \(key) answer")
        
        guard let gestalt = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_LAZY) else {
            logger.error("Could not load libMobileGestalt.dylib")
            return nil
        }
        
        guard let key = CFStringCreateWithCString(nil, key, CFStringBuiltInEncodings.ASCII.rawValue) else {
            logger.error("Unable to encode question key \(key)")
            return nil
        }
        
        mgKey = unsafeBitCast(dlsym(gestalt, "MGCopyAnswer"), to: MGKey.self)
        
        guard let value = mgKey?(key) else {
            logger.error("Failed to get answer for key \(key)")
            return nil
        }
        
        let typeId = CFGetTypeID(value)
        
        switch typeId {
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
        
        return nil
    }
}
