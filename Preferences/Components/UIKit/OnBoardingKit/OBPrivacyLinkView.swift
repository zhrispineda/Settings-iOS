//
//  OBPrivacyLinkView.swift
//  Preferences
//

import SwiftUI

/// A UIViewControllerRepresentable instance for `OBPrivacyLinkController` from the OnBoardingKit framework.
///
/// - Parameter bundleIdentifiers: The array of onboarding bundle IDs to use.
///
/// - Warning: Do not use this method for public applications. It is not publicly supported.
struct OBPrivacyLinkView: UIViewControllerRepresentable {
    let bundleIdentifiers: [String]
    
    func makeUIViewController(context: Context) -> UIViewController {
        guard let controller = NSClassFromString("OBPrivacyLinkController") as? NSObject.Type else {
            return UIViewController()
        }
        
        if bundleIdentifiers.count > 1 {
            let selector = NSSelectorFromString("linkWithBundleIdentifiers:")
            let result = (controller.perform(selector, with: bundleIdentifiers)?.takeUnretainedValue() as? UIViewController)!
            return result
        } else {
            let selector = NSSelectorFromString("linkWithBundleIdentifier:")
            let result = (controller.perform(selector, with: bundleIdentifiers[0])?.takeUnretainedValue() as? UIViewController)!
            return result
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
