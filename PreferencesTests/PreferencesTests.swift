//
//  PreferencesTests.swift
//  PreferencesTests
//
//  Settings
//

import Testing
@testable import Preferences

struct PreferencesTests {
    // MARK: Identifier key
    @Test(arguments: [
        "h9jDsbgj7xIVeIQ8S3/X3Q"
    ])
    func testMGKey(key: String) async throws {
        let result = MGHelper.read(key: key) ?? String()
        #expect(result.isEmpty == false)
    }
}
