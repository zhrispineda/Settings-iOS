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
        
        let list = app.otherElements["SettingsList"]
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
    
    // MARK: Search TextField
    @MainActor
    func testSearchField() throws {
        let app = XCUIApplication()
        app.launch()

        let searchField = app.searchFields["Search"]
        XCTAssertTrue(searchField.exists, "Search field does not exist")

        searchField.firstMatch.tap()
        app.searchFields["Search"].firstMatch.typeText("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
        app.buttons["close"].firstMatch.tap()
    }
    
    // MARK: Search Suggestions Buttons
    @MainActor
    func testSearchSuggestions() throws {
        let app = XCUIApplication()
        app.launch()
        
        let buttons = ["Sounds & Haptics", "Notifications", "Focus", "Screen Time"]

        let searchField = app.searchFields["Search"]
        XCTAssertTrue(searchField.exists, "Search field does not exist")
        searchField.firstMatch.tap()
        
        for button in buttons {
            let btn = app.buttons.containing(.staticText, identifier: button).firstMatch
            
            if !btn.exists {
                XCTAssertTrue(btn.exists, "\(button) does not exist")
            }
            
            btn.tap()
            
            let back = app.buttons["BackButton"].firstMatch
            XCTAssertTrue(back.exists, "Back button does not exist")
            back.tap()
        }
        
        app.buttons["close"].firstMatch.tap()
    }
    
    // MARK: Settings > General [Scrolling]
    @MainActor
    func testGeneral() throws {
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = app.otherElements
        var element = elementsQuery.element(boundBy: 20)
        element.swipeUp()
        
        let generalButton = app.buttons["General"]
        XCTAssertTrue(generalButton.exists, "General link not found")
        generalButton.tap()
        element = elementsQuery.element(boundBy: 10)
        element.swipeUp()
    }
    
    // MARK: Check Accessibility Settings
    @MainActor
    func testSettingsAccessibilitySettingsExistence() throws {
        let app = XCUIApplication()
        app.launch()
        
        let accessibilityButton = app.buttons["Accessibility"].firstMatch
        if !accessibilityButton.exists {
            let elementsQuery = app.otherElements
            let element = elementsQuery.element(boundBy: 20)
            element.swipeUp()
        }
        XCTAssertTrue(accessibilityButton.exists, "Accessibility link not found")
        accessibilityButton.tap()
        let accessibilityTitle = app.staticTexts["Accessibility"]
        XCTAssertTrue(accessibilityTitle.exists, "Accessibility pane not found")
    }
    
    // MARK: Check Auto-Lock Settings
    @MainActor
    func testSettingsAutoLockSettingsExistence() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cameraButton = app.buttons["Camera"].firstMatch
        if !cameraButton.exists {
            let elementsQuery = app.otherElements
            let element = elementsQuery.element(boundBy: 20)
            element.swipeUp()
        } else {
            cameraButton.swipeUp()
        }
        let displayBrightnessButton = app.buttons["Display & Brightness"].staticTexts.firstMatch
        XCTAssertTrue(displayBrightnessButton.exists, "Display & Brightness link not found")
        displayBrightnessButton.tap()
        
        let brightnessHeader = app.staticTexts["Brightness"]
        brightnessHeader.swipeUp()
        
        let autoLockButton = app.buttons.containing(.staticText, identifier: "Auto-Lock").firstMatch
        XCTAssertTrue(autoLockButton.exists, "Auto-Lock link not found")
        autoLockButton.tap()
    }
    
    // MARK: Check Control Center Settings
    @MainActor
    func testSettingsControlCenterExistence() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cameraButton = app.buttons["Camera"].firstMatch
        if !cameraButton.exists {
            let elementsQuery = app.otherElements
            let element = elementsQuery.element(boundBy: 20)
            element.swipeUp()
        } else {
            cameraButton.swipeUp()
        }
        
        let controlCenterButton = app.buttons["Control Center"].staticTexts.firstMatch
        XCTAssertTrue(controlCenterButton.exists, "Control Center link not found")
        controlCenterButton.tap()
        
        let navTitle = app.staticTexts["Control Center"]
        XCTAssertTrue(navTitle.exists, "Control Center title not found")
    }
    
    // MARK: Check Display Text Size Settings
    @MainActor
    func testSettingsDisplayTextSizeSettingsExistence() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cameraButton = app.buttons["Camera"].firstMatch
        if !cameraButton.exists {
            let elementsQuery = app.otherElements
            let element = elementsQuery.element(boundBy: 20)
            element.swipeUp()
        } else {
            cameraButton.swipeUp()
        }
        
        let displayBrightnessButton = app.buttons["Display & Brightness"].staticTexts.firstMatch
        XCTAssertTrue(displayBrightnessButton.exists, "Display & Brightness link not found")
        displayBrightnessButton.tap()
        
        let textSizeButton = app.buttons["Text Size"].staticTexts.firstMatch
        XCTAssertTrue(textSizeButton.exists, "Text Size link not found")
        textSizeButton.tap()
    }
    
    // MARK: Check Focus Settings Navigation
    @MainActor
    func testSettingsFocusNavigate() throws {
        let app = XCUIApplication()
        app.launch()

        let battery = app.buttons["Battery"]
        XCTAssertTrue(battery.exists, "Battery link not found")
        battery.firstMatch.swipeUp()

        let homeScreen = app.buttons["Home Screen & App Library"]
        XCTAssertTrue(homeScreen.exists, "Home Screen & App Library link not found")
        homeScreen.firstMatch.swipeUp()

        let focus = app.buttons["Focus"]
        XCTAssertTrue(focus.exists, "Focus link not found")
        focus.firstMatch.tap()

        let back = app.buttons["BackButton"]
        XCTAssertTrue(back.exists, "Back button not found")
        back.firstMatch.tap()
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
