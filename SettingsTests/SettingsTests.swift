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
        "EqrsVvjcYDdxHBiQmGhAWw", // apple-internal-install
        "mZfUC7qo4pURNhyMHZ62RQ", // BuildVersion
        "2pxKjejpRGpWvUE+3yp5mQ", // cameraRestriction
        "j8/Omm6s1lsmTDFsXjsBfA", // DeviceSupportsAlwaysOnTime
        "qeaj75wk3HF4DwQ8qbIi7g", // DeviceSupportsEnhancedMultitasking
        "uyejyEdaxNWSRQQwHmXz1A", // DiskUsage
        "Pop5T2XQdDA60MRyxQJdQ", // hall-effect-sensor
        "fh6DnnDGDVZ5kZ9nYn/GrQ", // hdr-image-capture
        "JwLB44/jEB8aFDpXQ16Tuw", // HomeButtonType
        "ulMliLomP737aAOJ/w/evA", // IsSimulator
        "Z/dqyWS6OZTRy10UcmUAhw", // marketing-name
        "D0cJ8r7U5zve6uA6QbOiLA", // ModelNumber
        "8olRm6C1xqr7AJGpLRnpSw", // PearlIDCapability
        "h9jDsbgj7xIVeIQ8S3/X3Q", // ProductType
        "97JDvERpVwO+GHtthIh7hA", // RegulatoryModelNumber
        "XYlJKKkj2hztRP1NWWnhlw", // ResearchFuse
        "VasUgeSzVyHdB27g2XpN0g" // SerialNumber
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
