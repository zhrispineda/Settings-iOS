//
//  UIViewControllerRepresentables.swift
//  Preferences
//

import SwiftUI

// MARK: - HelpKit
// HLPHelpViewController for displaying user guide information.
struct HelpKitView: UIViewControllerRepresentable {
    let topicID: String

    func makeUIViewController(context: Context) -> UIViewController {
        let handle = dlopen("/System/Library/PrivateFrameworks/HelpKit.framework/HelpKit", RTLD_LAZY)
        defer { dlclose(handle) }

        guard let helpViewController = NSClassFromString("HLPHelpViewController") as? UIViewController.Type else {
            SettingsLogger.error("Could not load HLPHelpViewController")
            return UIViewController()
        }

        let instance = helpViewController.init()
        instance.setValue(topicID, forKey: "selectedHelpTopicID")

        let controller = UINavigationController(rootViewController: instance)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - OnBoardingKit
// OBPrivacyLinkController for displaying a privacy splash link.
struct OBPrivacyLinkView: UIViewControllerRepresentable {
    let bundleIdentifiers: [String]
    
    func makeUIViewController(context: Context) -> UIViewController {
        guard let handle = dlopen("/System/Library/PrivateFrameworks/OnBoardingKit.framework/OnBoardingKit", RTLD_LAZY) else {
            return UIViewController()
        }
        defer { dlclose(handle) }
        
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

// OBPrivacyLinkController for displaying several bundles in one view.
struct OBCombinedSplashView: UIViewControllerRepresentable {
    let bundleIdentifiers: [String]
    @Binding var showingSheet: Bool
    
    init(_ bundleIdentifiers: [String], showingSheet: Binding<Bool>) {
        self.bundleIdentifiers = bundleIdentifiers
        self._showingSheet = showingSheet
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = OBCombinedSplashController(bundleIdentifiers: bundleIdentifiers)
        context.coordinator.controller = controller
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showingSheet {
            context.coordinator.trigger()
            DispatchQueue.main.async {
                self.showingSheet = false
            }
        }
    }
    
    class Coordinator {
        weak var controller: OBCombinedSplashController?
        
        @MainActor func trigger() {
            controller?.triggerPrivacyPresentation()
        }
    }
    
    class OBCombinedSplashController: UIViewController {
        private var privacyVC: UIViewController?
        private let bundleIdentifiers: [String]
        
        init(bundleIdentifiers: [String]) {
            self.bundleIdentifiers = bundleIdentifiers
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .clear
            
            guard let handle = dlopen("/System/Library/PrivateFrameworks/OnBoardingKit.framework/OnBoardingKit", RTLD_LAZY) else {
                return
            }
            defer { dlclose(handle) }
            
            guard let controller = NSClassFromString("OBPrivacyLinkController") as? NSObject.Type else {
                return
            }
            
            let selector = NSSelectorFromString("linkWithBundleIdentifiers:")
            
            guard let result = controller.perform(selector, with: bundleIdentifiers)?.takeUnretainedValue() as? UIViewController else {
                return
            }
            
            self.privacyVC = result
            addChild(result)
        }
        
        func triggerPrivacyPresentation() {
            privacyVC?.perform(NSSelectorFromString("linkPressed"))
        }
    }
}

// OBPrivacySplashController for displaying privacy information.
struct OnBoardingKitView: UIViewControllerRepresentable {
    let bundleID: String
    let showLinkToPrivacyGateway: Bool
    let showsLinkToUnifiedAbout: Bool
    
    init(bundleID: String, showLinkToPrivacyGateway: Bool = false, showsLinkToUnifiedAbout: Bool = true) {
        self.bundleID = bundleID
        self.showLinkToPrivacyGateway = showLinkToPrivacyGateway
        self.showsLinkToUnifiedAbout = showsLinkToUnifiedAbout
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let handle = dlopen("/System/Library/PrivateFrameworks/OnBoardingKit.framework/OnBoardingKit", RTLD_LAZY)
        defer { dlclose(handle) }
        
        guard let controller = NSClassFromString("OBPrivacySplashController") as? NSObject.Type else {
            return NSObject() as! UIViewController
        }
        
        let selector = Selector(("splashPageWithBundleIdentifier:"))
        let method = controller.method(for: selector)
        typealias FunctionType = @convention(c) (AnyObject, Selector, Any) -> AnyObject?
        let function = unsafeBitCast(method, to: FunctionType.self)
        
        if let splashController = function(controller, selector, bundleID) as? UIViewController {
            splashController.setValue(showLinkToPrivacyGateway, forKey: "showLinkToPrivacyGateway")
            splashController.setValue(showsLinkToUnifiedAbout, forKey: "showsLinkToUnifiedAbout")
            
            let dismissButton = UIBarButtonItem(title: "Done", style: .done, target: splashController, action: #selector(UIViewController.dismissView))
            splashController.navigationItem.rightBarButtonItem = dismissButton
            
            let navController = UINavigationController(rootViewController: splashController)
            return navController
        }
        
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - SoftwareUpdateSettings
// SUSSoftwareUpdateReleaseNotesDetail for displaying release notes
struct ReleaseNotesViewController: UIViewControllerRepresentable {
    let readMeName: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        let handle = dlopen("/System/Library/PrivateFrameworks/SoftwareUpdateSettings.framework/SoftwareUpdateSettings", RTLD_LAZY)
        defer { dlclose(handle) }
        
        guard let controllerClass = NSClassFromString("SUSSoftwareUpdateReleaseNotesDetail") as? UIViewController.Type else {
            SettingsLogger.error("Could not load SUSSoftwareUpdateReleaseNotesDetail")
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
            SettingsLogger.error("Could not load SUSSoftwareUpdateReleaseNotesDetail file: \(fileName)")
            return nil
        }
        
        do {
            return try String(contentsOfFile: filePath, encoding: .utf8)
        } catch {
            SettingsLogger.error("Could not load SUSSoftwareUpdateReleaseNotesDetail ReadMe: \(error)")
            return nil
        }
    }
}

// MARK: - Other

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
        SettingsLogger.info("Retrieving preferences plugin with name '\(controller)' at location 'PreferencesPluginLocation: { directoryURL: 'file://\(path)'}'.")
        
        guard let handle = dlopen(path, RTLD_LAZY) else {
            SettingsLogger.error("Could not load framework: \(path)")
            return UIViewController()
        }
        defer { dlclose(handle) }
        
        guard let controller = NSClassFromString(controller) as? UIViewControllerType.Type else {
            SettingsLogger.error("Could not load controller: \(controller)")
            return UIViewController()
        }
        
        let bundleSelector = Selector(("pe_emitNavigationEventForApplicationSettingsWithApplicationBundleIdentifier:title:localizedNavigationComponents:deepLink:"))
        if !(controller as AnyObject).responds(to: bundleSelector) {
            let methodImp: @convention(block) (AnyObject, Any?, Any?, Any?, Any?) -> Void = { _, _, _, _, _ in }
            let imp = imp_implementationWithBlock(methodImp)
            _ = class_addMethod(controller, bundleSelector, imp, "v@:@@@@")
        }
        
        let iconSelector = Selector(("pe_emitNavigationEventForSystemSettingsWithGraphicIconIdentifier:title:localizedNavigationComponents:deepLink:"))
        if !(controller as AnyObject).responds(to: iconSelector) {
            let methodImp: @convention(block) (AnyObject, Any?, Any?, Any?, Any?) -> Void = { _, _, _, _, _ in }
            let imp = imp_implementationWithBlock(methodImp)
            _ = class_addMethod(controller, iconSelector, imp, "v@:@@@@")
        }
        
        let instance = controller.init()
        
        SettingsLogger.info("Loading plugin with name '\(controller)' at location '{ directoryURL: 'file://\(path)'}'.")
        
        return instance
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
