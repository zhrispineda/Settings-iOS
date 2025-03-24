//
//  UIWindowExtensions.swift
//  Preferences
//

import SwiftUI

extension UIWindow {
    static var key: UIWindow {
        return UIWindow.value(forKey: "keyWindow") as! UIWindow
    }
    
    static var controller: UIViewController {
        return key.rootViewController!
    }
}
