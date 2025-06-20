//
//  UIImageExtensions.swift
//  Preferences
//

import SwiftUI

extension UIImage {
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

    static func icon(forBundleID bundleID: String) -> UIImage? {
        let selector = NSSelectorFromString("ps_synchronousIconWithApplicationBundleIdentifier:")
        guard UIImage.responds(to: selector) else {
            return nil
        }

        let image = UIImage.perform(selector, with: bundleID)
        return image?.takeUnretainedValue() as? UIImage
    }
}
