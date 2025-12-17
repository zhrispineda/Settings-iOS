//
//  SettingsTopLevelPanesRenderTests.swift
//  SettingsTests
//

import XCTest

final class SettingsTopLevelPanesRenderTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Checks if Settings > Camera is available
    func testSettingsAppsCameraIsRendered() throws {
        let app = XCUIApplication()
        app.launch()
        
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        
        let cameraButton = app.buttons["com.apple.settings.camera"]
        var swipeCount = 0
        
        while !cameraButton.exists && swipeCount < 5 {
            list.swipeUp(velocity: .slow)
            swipeCount += 1
        }
        
        XCTAssertTrue(cameraButton.exists, "Camera link not found")
        cameraButton.tap()
    }
    
    /// Checks if Settings > Bluetooth is available
    func testSettingsBluetoothNavigation() throws {
        let app = XCUIApplication()
        app.launch()
        
        let list = app.otherElements["SettingsList"]
        XCTAssertTrue(list.exists, "Settings list not found")
        
        let bluetoothButton = app.buttons["com.apple.settings.bluetooth"]
        var swipeCount = 0
        
        while !bluetoothButton.exists && swipeCount < 5 {
            list.swipeUp(velocity: .slow)
            swipeCount += 1
        }
        
        XCTAssertTrue(bluetoothButton.exists, "Bluetooth link not found")
        bluetoothButton.tap()
    }
    
    /// Checks if Settings > Accessibility is available
    func testSettingsTopLevelAccessibilityIsRendered() throws {
        let app = XCUIApplication()
        app.launch()
        
        let list = app.otherElements["SettingsList"]
        XCTAssertTrue(list.exists, "Settings list not found")
        
        let accessibilityButton = app.buttons["com.apple.settings.accessibility"]
        var swipeCount = 0
        
        while !accessibilityButton.exists && swipeCount < 5 {
            list.swipeUp(velocity: .slow)
            swipeCount += 1
        }
        
        XCTAssertTrue(accessibilityButton.exists, "Accessibility link not found")
        accessibilityButton.tap()
    }
    
    /// Checks if Settings > Action Button is available
    func testSettingsTopLevelActionButtonIsRendered() throws {
        try XCTSkipIf(UIDevice.current.userInterfaceIdiom == .pad, "iPad not suppported")
        
        let app = XCUIApplication()
        app.launch()
        
        let list = app.otherElements["SettingsList"]
        XCTAssertTrue(list.exists, "Settings list not found")
        
        let actionButtonLink = app.buttons["com.apple.settings.actionButton"]
        var swipeCount = 0
        
        while !actionButtonLink.exists && swipeCount < 5 {
            list.swipeUp(velocity: .slow)
            swipeCount += 1
        }
        
        XCTAssertTrue(actionButtonLink.exists, "Action Button link not found")
        actionButtonLink.tap()
    }
    
    /// Checks if Settings > Apps > App Store is available
    func testSettingsTopLevelAppStoreIsRendered() throws {
        try XCTSkipIf(ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] != nil, "Simulator not supported")
        
        let app = XCUIApplication()
        app.launch()
        
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        XCTAssertTrue(list.exists, "Settings list not found")
        
        let appsLink = app.buttons["com.apple.settings.apps"]
        var swipeCount = 0
        
        while !appsLink.exists && swipeCount < 10 {
            list.swipeUp(velocity: .slow)
            swipeCount += 1
        }
        
        XCTAssertTrue(appsLink.exists, "Apps link not found")
        appsLink.tap()
        
        let appStoreLink = app.buttons["App Store"]
        XCTAssertTrue(appStoreLink.exists, "App Store link not found")
        appStoreLink.tap()
    }
    
    /// Checks if Settings > Battery is available
    func testSettingsTopLevelBatteryIsRendered() throws {
        let app = XCUIApplication()
        app.launch()
        
        let batteryLink = app.buttons["com.apple.settings.battery"]
        XCTAssertTrue(batteryLink.exists, "Battery link not found")
        batteryLink.tap()
    }
    
    /// Checks if Settings > Bluetooth is available
    func testSettingsTopLevelBluetoothIsRendered() throws {
        let app = XCUIApplication()
        app.launch()
        
        let bluetoothLink = app.buttons["com.apple.settings.bluetooth"]
        XCTAssertTrue(bluetoothLink.exists, "Bluetooth link not found")
        bluetoothLink.tap()
    }
    
    /// Checks if Settings > Camera is available
    func testSettingsTopLevelCameraIsRendered() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cameraLink = app.buttons["com.apple.settings.camera"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !cameraLink.exists && swipeCount < 5 {
            list.swipeUp(velocity: .slow)
            swipeCount += 1
        }
        XCTAssertTrue(cameraLink.exists, "Camera link not found")
        cameraLink.tap()
    }
    
    /// Checks if Settings > Cellular is available
    func testSettingsTopLevelCellularIsRendered() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cellularLink = app.buttons["com.apple.settings.cellular"]
        XCTAssertTrue(cellularLink.exists, "Cellular link not found")
        cellularLink.tap()
    }
    
    /// Checks if Settings > Apps > Compass is available
    func testSettingsTopLevelCompassIsRendered() throws {
        try XCTSkipIf(ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] != nil, "Simulator not supported")
        
        let app = XCUIApplication()
        app.launch()
        
        let appsLink = app.buttons["com.apple.settings.apps"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !appsLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(appsLink.exists, "Apps link not found")
        appsLink.tap()
        
        let compassLink = app.buttons["Compass"]
        XCTAssertTrue(compassLink.exists, "Compass link not found")
        compassLink.tap()
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
