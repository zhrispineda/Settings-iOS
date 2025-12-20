//
//  HLPHelpViewController.swift
//  Preferences
//

import SwiftUI

/// A UIViewControllerRepresentable instance for `HLPHelpViewController` from the HelpKit framework.
///
/// - Parameter topicID: The topic ID to display.
///
/// - Warning: Do not use this method for public applications. It is not publicly supported.
struct HLPHelpViewController: UIViewControllerRepresentable {
    let topicID: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        dlopen("/System/Library/PrivateFrameworks/HelpKit.framework/HelpKit", RTLD_NOW)
        
        guard let helpViewController = NSClassFromString("HLPHelpViewController") as? UIViewController.Type else {
            SettingsLogger.error("Could not load HLPHelpViewController")
            return UIViewController()
        }
        
        let instance = helpViewController.init()
        
        instance.setValue(topicID, forKey: "selectedHelpTopicID")
        
        return UINavigationController(rootViewController: instance)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
