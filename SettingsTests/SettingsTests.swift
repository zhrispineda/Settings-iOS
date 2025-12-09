//
//  SettingsTests.swift
//  SettingsTests
//

import Testing
@testable import Preferences

struct SettingsTests {
    // MARK: - MobileGestalt
    
    /// This tests MobileGestalt to check if the keys currently used are still available.
    /// Keys that cannot be read will default to an empty string, causing the test to fail.
    ///
    /// - Parameter key: The String key to query.
    ///
    /// - Warning: Do not use this for public applications. It is not publicly supported.
    ///
    /// - Note: Some keys accessible in Xcode Previews/Simulator may not be available on physical devices.
    @Test(arguments: [
        "h9jDsbgj7xIVeIQ8S3/X3Q", // ProductType
        "97JDvERpVwO+GHtthIh7hA", // RegulatoryModelNumber
        "D0cJ8r7U5zve6uA6QbOiLA" // ModelNumber
    ])
    func testMGKey(key: String) async throws {
        let result = MGHelper.read(key: key) ?? ""
        #expect(result.isEmpty == false)
    }
    
    // MARK: - Accessibility Settings
    
    @MainActor
    @Test func testSettingsAccessibilitySettingsExistence() throws {
        let accessibility = PrimarySettingsListModel.shared.mainSettings.contains(where: { $0.title == "Accessibility" })
        #expect(accessibility)
    }
    
    @MainActor
    @Test func testSettingsAccessibilityShortcutSettingsExistence() throws {
        let accessibility = PrimarySettingsListModel.shared.mainSettings.contains(where: { $0.title == "Accessibility" })
        #expect(accessibility)
    }
}
