//
//  UIViewControllerRepresentables.swift
//  Preferences
//

import SwiftUI

// MARK: ActionButtonSettings to display the 3D-rendered Action Button settings
struct ActionButtonViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let path = "/System/Library/PreferenceBundles/ActionButtonSettings.bundle/ActionButtonSettings"
        guard let handle = dlopen(path, RTLD_LAZY) else {
            return UIViewController()
        }
        defer { dlclose(handle) }
        
        guard let settingsClass = NSClassFromString("ActionButtonSettings") as? UIViewController.Type else {
            return UIViewController()
        }
        
        let instance = settingsClass.init()
        
        let selector = Selector(("pe_emitNavigationEventForSystemSettingsWithGraphicIconIdentifier:title:localizedNavigationComponents:deepLink:"))
        if !(instance as AnyObject).responds(to: selector) {
            let methodImp: @convention(block) (AnyObject, Any?, Any?, Any?, Any?) -> Void = { _, _, _, _, _ in }
            let imp = imp_implementationWithBlock(methodImp)
            _ = class_addMethod(settingsClass, selector, imp, "v@:@@@@")
        }
        
        return instance
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: HelpKit HLPHelpViewController for displaying user guide information
struct HelpKitView: UIViewControllerRepresentable {
    let topicID: String

    func makeUIViewController(context: Context) -> UIViewController {
        let path = "/System/Library/PrivateFrameworks/HelpKit.framework/HelpKit"
        let handle = dlopen(path, RTLD_LAZY)
        defer { dlclose(handle) }

        guard let HelpViewController = NSClassFromString("HLPHelpViewController") as? UIViewController.Type else {
            fatalError("Failed to load class: HLPHelpViewController")
        }

        let instance = HelpViewController.init()
        instance.setValue(topicID, forKey: "selectedHelpTopicID")

        let controller = UINavigationController(rootViewController: instance)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: GeneralSettingsUI PSGHomeButtonCustomizeController for adjusting home button haptic
// Missing permission/entitlement to disable backgrounding by home button
struct HomeButtonViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let path = "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework/GeneralSettingsUI"
        let handle = dlopen(path, RTLD_LAZY)
        defer { dlclose(handle) }
        
        let controller = NSClassFromString("PSGHomeButtonCustomizeController") as! UIViewControllerType.Type
        let instance = controller.init()
        
        return instance
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: SoftwareUpdateSettings SUSSoftwareUpdateReleaseNotesDetail for displaying release notes
struct ReleaseNotesViewController: UIViewControllerRepresentable {
    let readMeName: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        let path = "/System/Library/PrivateFrameworks/SoftwareUpdateSettings.framework/SoftwareUpdateSettings"
        guard let handle = dlopen(path, RTLD_LAZY) else {
            print("Framework failed to load: \(path)")
            return UIViewController()
        }
        defer { dlclose(handle) }
        
        guard let controllerClass = NSClassFromString("SUSSoftwareUpdateReleaseNotesDetail") as? UIViewController.Type else {
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
            print("ReadMe not found.")
            return nil
        }
        
        do {
            return try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            print("Error reading ReadMe: \(error)")
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
        let handle = dlopen(path, RTLD_LAZY)
        defer { dlclose(handle) }
        
        let controller = NSClassFromString(controller) as! UIViewControllerType.Type
        let instance = controller.init()
        
        return instance
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
