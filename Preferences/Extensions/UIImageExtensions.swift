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
    
    // MARK: - Experimental
    @MainActor static func asset(path: String, name: String) -> UIImage? {
        var newPath = ""

        if UIDevice.IsSimulated {
            guard let newBuild = MGHelper.read(key: "mZfUC7qo4pURNhyMHZ62RQ") else {
                return nil
            }
            newPath = "/Library/Developer/CoreSimulator/Volumes/iOS_\(newBuild)/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS \(UIDevice.current.systemVersion).simruntime/Contents/Resources/RuntimeRoot\(path)"
        } else {
            newPath = path
        }

        if let bundle = Bundle(path: newPath) {
            let image = UIImage(named: name, in: bundle, compatibleWith: nil)
            return image
        }
        
        return nil
    }
}
