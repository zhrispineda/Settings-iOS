//
//  Extensions.swift
//  Preferences
//

import Foundation
import SwiftUI

// MARK: String extension
extension String {
    /// A function for localizing a String with a specified table and optional argument.
    /// ```swift
    /// var body: some View {
    ///      Text("KEY_TO_LOCALIZE".localize(table: "TableName"))
    ///      Text("KEY_TO_LOCALIZE".localize(table: "TableName", "VARIABLE_TO_USE"))
    ///      Toggle("KEY_TO_LOCALIZE".localize(table: "TableName"), isOn: .constant(true))
    ///      Toggle("KEY_TO_LOCALIZE".localize(table: "TableName", "VARIABLE_TO_USE"), isOn: .constant(true))
    /// }
    /// ```
    /// - Parameter text: The ``String`` to localize.
    /// - Parameter table: The ``String`` localizable table name to use.
    /// - Parameter variable: The optional ``String`` to display as a variable.
    func localize(table: String, _ variable: String = String()) -> String {
        if variable.isEmpty {
            let localized = String.localizedStringWithFormat(NSLocalizedString(self, tableName: table, comment: ""))
            return localized
        } else {
            let localized = String.localizedStringWithFormat(NSLocalizedString(self, tableName: table, comment: ""), String(localized: String.LocalizationValue(variable), table: table))
            return localized
        }
    }
}

// MARK: Color extension
extension Color {
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
