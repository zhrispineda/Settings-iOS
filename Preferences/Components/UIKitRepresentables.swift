//
//  UIKitRepresentables.swift
//  Preferences
//

import SwiftUI

// MARK: - AuthKitUI
/// Bring Device Nearby view for logging into Apple Accounts with a nearby device.
struct ProximityViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        var path = "/System/Library/PrivateFrameworks/AuthKitUI.framework/AuthKitUI"
        dlopen(path, RTLD_NOW)
        
        guard
            let viewModelClass = NSClassFromString("AKProximityMessageViewModel") as? NSObject.Type,
            let viewControllerClass = NSClassFromString("AKProximityAuthViewController") as? NSObject.Type
        else {
            return UIViewController()
        }
        
        let alloc = NSSelectorFromString("alloc")
        let initWithType = Selector(("initWithType:"))
        let initWithViewModel = Selector(("initWithViewModel:"))
        
        let allocMethod = viewModelClass.method(for: alloc)
        let initMethod = class_getMethodImplementation(viewModelClass, initWithType)
        
        typealias AllocType = @convention(c) (AnyObject, Selector) -> AnyObject
        typealias InitVMType = @convention(c) (AnyObject, Selector, UInt64) -> AnyObject
        
        let vmAlloc = unsafeBitCast(allocMethod, to: AllocType.self)
        let vmInit = unsafeBitCast(initMethod, to: InitVMType.self)
        
        let viewModel = vmInit(vmAlloc(viewModelClass, alloc), initWithType, 0)
        path = "/System/Library/PrivateFrameworks/AuthKitUI.framework"
        viewModel.setValue("PROXIMITY_AUTH_BROADCAST_TITLE".localized(path: path), forKey: "titleText")
        viewModel.setValue(UIDevice.iPhone ? "PROXIMITY_AUTH_BROADCAST_DESCRIPTION_IPHONE".localized(path: path) : "PROXIMITY_AUTH_BROADCAST_DESCRIPTION_IPAD".localized(path: path), forKey: "detailedText")
        
        typealias InitVCType = @convention(c) (AnyObject, Selector, AnyObject) -> AnyObject
        
        let vcAlloc = unsafeBitCast(viewControllerClass.method(for: alloc), to: AllocType.self)
        let vcInit = unsafeBitCast(class_getMethodImplementation(viewControllerClass, initWithViewModel), to: InitVCType.self)
        
        let controller = vcInit(vcAlloc(viewControllerClass, alloc), initWithViewModel, viewModel)
        
        return controller as! UIViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - OnBoardingKit
struct OBBoldTrayButton: UIViewRepresentable {
    var titleKey: String
    let action: () -> Void
    
    init(_ titleKey: String, action: @escaping () -> Void = {}) {
        self.titleKey = titleKey
        self.action = action
    }
    
    func makeUIView(context: Context) -> UIButton {
        guard dlopen("/System/Library/PrivateFrameworks/OnBoardingKit.framework/OnBoardingKit", RTLD_NOW) != nil else {
            return UIButton()
        }
        
        guard let buttonClass = NSClassFromString("OBBoldTrayButton") as? NSObject.Type,
              let button = buttonClass.perform(NSSelectorFromString("boldButton"))?.takeUnretainedValue() as? UIButton else {
            return UIButton()
        }
        
        button.setTitle(titleKey, for: .normal)
        button.addTarget(context.coordinator, action: #selector(Coordinator.didTap), for: .touchUpInside)
        
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    class Coordinator {
        let action: () -> Void
        
        init(action: @escaping () -> Void) {
            self.action = action
        }
        
        @objc func didTap() {
            action()
        }
    }
}

/// OBPrivacyLinkController for displaying a privacy splash link.
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

/// OBPrivacyLinkController for displaying several bundles in one view.
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
            Task {
                self.showingSheet = false
            }
        }
    }
    
    class Coordinator {
        weak var controller: OBCombinedSplashController?
        
        @MainActor
        func trigger() {
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
        
        required init?(coder: NSCoder) { fatalError() }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
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

/// OBPrivacySplashController for displaying privacy information.
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
            
            let checkmarkImage = UIImage(systemName: "xmark")
            let dismissButton = UIBarButtonItem(image: checkmarkImage, style: .plain, target: splashController, action: #selector(UIViewController.dismissView))
            splashController.navigationItem.leftBarButtonItem = dismissButton
            
            let navController = UINavigationController(rootViewController: splashController)
            return navController
        }
        
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - Other

/// A view controller bridge based on a given path and class name.
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
        
        guard dlopen(path, RTLD_NOW) != nil else {
            SettingsLogger.error("Could not load framework: \(path)")
            return UIViewController()
        }
        
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
        
        let actionSelector = Selector(("pe_registerUndoActionName:associatedDeepLink:undoAction:"))
        if !(controller as AnyObject).responds(to: actionSelector) {
            let methodImp: @convention(block) (AnyObject, Any?, Any?, @escaping () -> Void) -> Void = { _, _, _, _ in }
            let imp = imp_implementationWithBlock(methodImp)
            _ = class_addMethod(controller, actionSelector, imp, "v@:@@?")
        }
        
        SettingsLogger.info("Loading plugin with name '\(controller)' at location '{ directoryURL: 'file://\(path)'}'.")
        
        let vc = controller.init()
        
        // If accessing Face ID enrollment controller, disable `Get Started` button for now
        if self.controller == "BKUIPearlEnrollController" {
            if let enrollVC = (vc as NSObject).value(forKey: "enrollViewController") as? NSObject {
                enrollVC.perform(Selector(("cancelEnroll")))
            }
        }
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

/// A view bridge based on a given path and class name.
///
/// - Parameter path: The path of the framework.
/// - Parameter controller: The string name of the class.
struct CustomView: UIViewRepresentable {
    let path: String
    let controller: String
    
    init(_ path: String, controller: String) {
        self.path = path
        self.controller = controller
    }
    
    func makeUIView(context: Context) -> UIView {
        if path.contains("/") {
            guard dlopen(path, RTLD_NOW) != nil else {
                SettingsLogger.error("Could not load framework: \(path)")
                return UIView()
            }
        } else {
            guard dlopen("/System/Library/PrivateFrameworks/\(path).framework/\(path)", RTLD_NOW) != nil else {
                SettingsLogger.error("Could not load framework: \(path)")
                return UIView()
            }
        }
        
        guard let view = NSClassFromString(controller) as? UIView.Type else {
            SettingsLogger.error("Could not load view: \(controller)")
            return UIView()
        }
        
        return view.init()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
