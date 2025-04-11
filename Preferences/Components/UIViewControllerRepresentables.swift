//
//  UIViewControllerRepresentables.swift
//  Preferences
//

import SwiftUI

// MARK: ActionButtonSettings to display the 3D-rendered Action Button settings
struct ActionButtonViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let handle = dlopen("/System/Library/PreferenceBundles/ActionButtonSettings.bundle/ActionButtonSettings", RTLD_LAZY)
        defer { dlclose(handle) }
        
        guard let settingsClass = NSClassFromString("ActionButtonSettings") as? UIViewController.Type else {
            logger.error("Could not load ActionButtonSettings")
            return UIViewController()
        }
        
        let instance = settingsClass.init()
        
        let selector = Selector(("pe_emitNavigationEventForSystemSettingsWithGraphicIconIdentifier:title:localizedNavigationComponents:deepLink:"))
        let methodImp: @convention(block) (AnyObject, Any?, Any?, Any?, Any?) -> Void = { _, _, _, _, _ in }
        let imp = imp_implementationWithBlock(methodImp)
        _ = class_addMethod(settingsClass, selector, imp, "v@:@@@@")
        
        return instance
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: HelpKit HLPHelpViewController for displaying user guide information
struct HelpKitView: UIViewControllerRepresentable {
    let topicID: String

    func makeUIViewController(context: Context) -> UIViewController {
        let handle = dlopen("/System/Library/PrivateFrameworks/HelpKit.framework/HelpKit", RTLD_LAZY)
        defer { dlclose(handle) }

        guard let helpViewController = NSClassFromString("HLPHelpViewController") as? UIViewController.Type else {
            logger.error("Could not load HLPHelpViewController")
            return UIViewController()
        }

        let instance = helpViewController.init()
        instance.setValue(topicID, forKey: "selectedHelpTopicID")

        let controller = UINavigationController(rootViewController: instance)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: OnBoardingKit for displaying privacy information
struct OBPrivacyLinkView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        guard let handle = dlopen("/System/Library/PrivateFrameworks/OnBoardingKit.framework/OnBoardingKit", RTLD_LAZY) else {
            return UIViewController()
        }
        defer { dlclose(handle) }
        
        guard let controller = NSClassFromString("OBPrivacyLinkController") as? NSObject.Type else {
            return UIViewController()
        }
        
        let selector = NSSelectorFromString("linkWithBundleIdentifier:")
        let bundleIdentifiers = "com.apple.onboarding.appleid"
        let result = (controller.perform(selector, with: bundleIdentifiers)?.takeUnretainedValue() as? UIViewController)!
        return result
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: SoftwareUpdateSettings SUSSoftwareUpdateReleaseNotesDetail for displaying release notes
struct ReleaseNotesViewController: UIViewControllerRepresentable {
    let readMeName: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        let handle = dlopen("/System/Library/PrivateFrameworks/SoftwareUpdateSettings.framework/SoftwareUpdateSettings", RTLD_LAZY)
        defer { dlclose(handle) }
        
        guard let controllerClass = NSClassFromString("SUSSoftwareUpdateReleaseNotesDetail") as? UIViewController.Type else {
            logger.error("Could not load SUSSoftwareUpdateReleaseNotesDetail")
            return UIViewController()
        }
        
        let instance = controllerClass.init()
        
        if let readMe = loadReadMe(named: readMeName) {
            instance.setValue(readMe, forKey: "releaseNotes")
        }
        
        return instance
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    private func loadReadMe(named fileName: String) -> String? {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "html") else {
            logger.error("Could not load SUSSoftwareUpdateReleaseNotesDetail file: \(fileName)")
            return nil
        }
        
        do {
            return try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            logger.error("Could not load SUSSoftwareUpdateReleaseNotesDetail ReadMe: \(error)")
            return nil
        }
    }
}

/// A UIViewControllerRepresentable method to load view controllers directly.
///
/// - Parameter path: The path of the framework.
/// - Parameter controller: The string name of the class.
struct CustomViewController: UIViewControllerRepresentable {
    let path: String
    let controller: String
    
    init(_ path: String, controller: String) {
        self.path = path
        self.controller = controller
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        guard let handle = dlopen(path, RTLD_LAZY) else {
            logger.error("Could not load framework: \(path)")
            return UIViewController()
        }
        defer { dlclose(handle) }
        
        guard let controller = NSClassFromString(controller) as? UIViewControllerType.Type else {
            logger.error("Could not load controller: \(controller)")
            return UIViewController()
        }
        let instance = controller.init()
        
        return instance
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
