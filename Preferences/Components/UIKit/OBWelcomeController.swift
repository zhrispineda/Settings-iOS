//
//  OBWelcomeController.swift
//  Preferences
//

import SwiftUI

struct OBWelcomeView: UIViewControllerRepresentable {
    let title: String
    let detailText: String
    var contentLayout: Int64 = 2
    
    func makeUIViewController(context: Context) -> UIViewController {
        guard let OBWelcomeControllerClass = NSClassFromString("OBWelcomeController") as? NSObject.Type else {
            return UIViewController()
        }
        
        let welcomeController = OBWelcomeControllerClass.perform(NSSelectorFromString("alloc")).takeUnretainedValue() as! NSObject
        
        let selector = NSSelectorFromString("initWithTitle:detailText:icon:contentLayout:")
        
        typealias InitFunction = @convention(c) (NSObject, Selector, NSString, NSString, NSObject?, Int64) -> UIViewController
        
        guard let method = welcomeController.method(for: selector) else {
            return UIViewController()
        }
        
        let initFunction = unsafeBitCast(method, to: InitFunction.self)
        
        return initFunction(
            welcomeController,
            selector,
            title as NSString,
            detailText as NSString,
            nil as NSObject?,
            contentLayout
        )
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
