//
//  SettingsTests.swift
//  SettingsTests
//

import Testing
@testable import Preferences

struct SettingsTests {
    
    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    // MARK: Identifier key
    @Test(arguments: [
        "h9jDsbgj7xIVeIQ8S3/X3Q"
    ])
    func testMGKey(key: String) async throws {
        let result = MGHelper.read(key: key) ?? String()
        #expect(result.isEmpty == false)
    }
    
    // MARK: Check Accessibility Settings
    @MainActor
    @Test func testSettingsAccessibilitySettingsExistence() throws {
        let accessibility = mainSettings.contains(where: { $0.title == "Accessibility" })
        #expect(accessibility)
    }
    
    // MARK: Check Accessibility Link
    @MainActor
    @Test func testSettingsAccessibilityShortcutSettingsExistence() throws {
        let accessibility = mainSettings.contains(where: { $0.title == "Accessibility" })
        #expect(accessibility)
    }
}
