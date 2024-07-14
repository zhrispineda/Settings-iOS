//
//  ColorExtensions.swift
//  Preferences
//  An extension on Colors to add custom colors.
//

import Foundation
import SwiftUI

public extension Color {
    static subscript(name: String) -> Color {
        switch name {
        case "Label":
            return Color(UIColor.label)
        case "Gray":
            return Color.gray
        case "White":
            return Color.white
        case "Blue":
            return Color.blue
        case "Red":
            return Color.red
        case "Green":
            return Color.green
        case "Yellow":
            return Color.yellow
        case "Orange":
            return Color.orange
        case "Pink":
            return Color.pink
        case "Purple":
            return Color.purple
        default:
            return Color.clear
        }
    }
}
