//
//  OBPrivacySplashController.swift
//  Preferences
//

import SwiftUI

/// A UIViewControllerRepresentable instance from OnBoardingKit.
///
/// - Parameter bundleID: The string onboarding bundle ID to use.
/// - Parameter showLinkToPrivacyGateway: Bool for whether to show a privacy gateway link. (Default: false)
/// - Parameter showsLinkToUnifiedAbout: Bool for whether to show a link for Data & Privacy. (Default: true)
///
/// - Warning: Do not use this method for public applications. It is not publicly supported.
struct OBPrivacySplashController: UIViewControllerRepresentable {
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

#Preview {
    OBPrivacySplashController(bundleID: "com.apple.onboarding.airdrop")
        .ignoresSafeArea()
}
