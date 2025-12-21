//
//  UIImageExtensions.swift
//  Preferences
//

import SwiftUI

extension UIImage {
    /// Returns an icon as a UIImage given a Uniform Type Identifier.
    ///
    /// - Parameter forUTI: The string Uniform Type Identifier to use.
    ///
    /// - Returns: UIImage with a blank page icon as a fallback.
    ///
    /// - Warning: Do not use this method for public applications. It is not publicly supported.
    static func icon(forUTI uti: String) -> UIImage? {
        let path = "/System/Library/PrivateFrameworks/Preferences.framework/Preferences"

        if dlopen(path, RTLD_NOLOAD) == nil {
            dlopen(path, RTLD_NOW)
        }
        
        let selector = NSSelectorFromString("ps_synchronousIconWithTypeIdentifier:")
        guard UIImage.responds(to: selector) else {
            return nil
        }

        let image = UIImage.perform(selector, with: uti)
        return image?.takeUnretainedValue() as? UIImage
    }
    
    /// Returns an icon as a UIImage given a string bundle ID.
    ///
    /// - Parameter bundleID: The string bundle ID to use.
    ///
    /// - Returns: UIImage with a template icon as a fallback.
    ///
    /// - Warning: Do not use this method for public applications. It is not publicly supported.
    static func icon(forBundleID bundleID: String) -> UIImage? {
        let selector = NSSelectorFromString("ps_synchronousIconWithApplicationBundleIdentifier:")
        guard UIImage.responds(to: selector) else {
            return nil
        }

        let image = UIImage.perform(selector, with: bundleID)
        return image?.takeUnretainedValue() as? UIImage
    }
}
