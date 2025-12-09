//
//  AKProximityAuthViewController.swift
//  Preferences
//

import SwiftUI

/// A UIViewRepresentable instance for `AKProximityAuthViewController` from the AuthKitUI framework.
///
/// - Warning: Do not use this method for public applications. It is not publicly supported.
/// - Warning: This class is not present in Simulator/Xcode Previews.
struct AKProximityAuthViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        var path = "/System/Library/PrivateFrameworks/AuthKitUI.framework/AuthKitUI"
        dlopen(path, RTLD_NOW)
        
        guard
            let viewModelClass = NSClassFromString("AKProximityMessageViewModel") as? NSObject.Type,
            let viewControllerClass = NSClassFromString("AKProximityAuthViewController") as? NSObject.Type
        else {
            SettingsLogger.error("Could not load AKProximityAuthViewController")
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
        viewModel.setValue(UIDevice.iPhone
                           ? "PROXIMITY_AUTH_BROADCAST_DESCRIPTION_IPHONE".localized(path: path)
                           : "PROXIMITY_AUTH_BROADCAST_DESCRIPTION_IPAD".localized(path: path),
                           forKey: "detailedText"
        )
        
        typealias InitVCType = @convention(c) (AnyObject, Selector, AnyObject) -> AnyObject
        
        let vcAlloc = unsafeBitCast(viewControllerClass.method(for: alloc), to: AllocType.self)
        let vcInit = unsafeBitCast(class_getMethodImplementation(viewControllerClass, initWithViewModel), to: InitVCType.self)
        
        let controller = vcInit(vcAlloc(viewControllerClass, alloc), initWithViewModel, viewModel)
        
        return controller as! UIViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
