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
    
    /// Returns an UIImage from a bundle if it exists.
    ///
    /// ```swift
    /// var body: some View {
    ///      if let asset = UIImage.asset(path: "Example.bundle", name: "exampleIcon") {
    ///         Image(uiImage: asset)
    ///      }
    /// }
    /// ```
    ///
    /// - Parameter path: The path of the bundle.
    /// - Parameter name: The name of the asset.
    @MainActor
    static func asset(path: String, name: String) -> UIImage? {
        if let bundle = Bundle(path: UIDevice.RuntimePath + "\(path)") {
            let image = UIImage(named: name, in: bundle, compatibleWith: nil)
            return image
        }
        
        return nil
    }
}
