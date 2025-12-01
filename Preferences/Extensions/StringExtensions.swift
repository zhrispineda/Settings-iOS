import SwiftUI

extension String {
    /// Returns a localized String given a path, optional table name, and optional multi-argument values.
    ///
    /// ```swift
    /// var body: some View {
    ///      Text("KEY_TO_LOCALIZE".localized(path: "/Path/To/Example.bundle", table: "TableName", "Example var"))
    /// }
    /// ```
    ///
    /// - Parameter path: The path of the bundle.
    /// - Parameter table: The name of the table.
    /// - Parameter variables: Optional multi-parameter values to display.
    ///
    /// - Returns: The localized String using the provided path, table, and variables.
    @MainActor
    func localized(path: String, table: String = "Localizable", _ variables: CVarArg...) -> String {
        var newPath = ""

        if UIDevice.IsSimulated {
            newPath = "/Library/Developer/CoreSimulator/Volumes/iOS_\(UIDevice.buildVersion)/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS \(UIDevice.current.systemVersion).simruntime/Contents/Resources/RuntimeRoot\(path)"
        } else {
            newPath = path
        }

        if let bundle = Bundle(path: newPath) {
            let format = bundle.localizedString(forKey: self, value: nil, table: table)
            return String(format: format, locale: .current, arguments: variables)
        }

        return self
    }
}
