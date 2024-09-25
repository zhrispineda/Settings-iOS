//
//  StringExtensions.swift
//  Preferences
//
//  An extension on String to add a localization function.
//

import SwiftUI

extension String {
    /// A function for localizing a String with a specified table and optional argument.
    /// ```swift
    /// var body: some View {
    ///      Text("KEY_TO_LOCALIZE".localize(table: "TableName"))
    ///      Text("KEY_TO_LOCALIZE".localize(table: "TableName", "VARIABLE_TO_USE"))
    ///      Toggle("KEY_TO_LOCALIZE".localize(table: "TableName"), isOn: .constant(true))
    ///      Toggle("KEY_TO_LOCALIZE".localize(table: "TableName", "VARIABLE"), isOn: .constant(true))
    ///      Toggle("KEY_TO_LOCALIZE".localize(table: "TableName", "FIRST_VARIALBE", "SECOND_VARIABLE", "THIRD_VARIABLE"), isOn: .constant(true))
    /// }
    /// ```
    /// - Parameter text: The ``String`` to localize.
    /// - Parameter table: The ``String`` localizable table name to use.
    /// - Parameter variables: The optional multi-parameter ``String`` to display as a variable or as variables.
    
    func localize(table: String, _ variables: String...) -> String {
        let format = NSLocalizedString(self, tableName: table, comment: "")
        let localizedVariables = variables.map { String(localized: String.LocalizationValue($0), table: table) }
        
        return String(format: format, locale: .current, arguments: localizedVariables)
    }
}
