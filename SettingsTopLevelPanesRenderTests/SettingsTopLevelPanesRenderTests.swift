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
    
    /// Checks if Settings > Control Center is available
    func testSettingsTopLevelControlCenterIsRendered() throws {
        let app = XCUIApplication()
        app.launch()
        
        let controlCenterLink = app.buttons["com.apple.settings.controlCenter"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !controlCenterLink.exists && swipeCount < 5 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(controlCenterLink.exists, "Control Center link not found")
        controlCenterLink.tap()
    }
    
    /// Checks if Settings > Display & Brightness is available
    func testSettingsTopLevelDisplayAndBrightnessIsRendered() throws {
        let app = XCUIApplication()
        app.launch()
        
        let displayBrightnessLink = app.buttons["com.apple.settings.displayAndBrightness"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !displayBrightnessLink.exists && swipeCount < 5 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(displayBrightnessLink.exists, "Display & Brightness link not found")
        displayBrightnessLink.tap()
    }
    
    /// Checks if Settings > Emergency SOS is available
    func testSettingsTopLevelEmergencySOSIsRendered() throws {
        let app = XCUIApplication()
        app.launch()
        
        let emergencyLink = app.buttons["com.apple.settings.sos"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !emergencyLink.exists && swipeCount < 5 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(emergencyLink.exists, "Emergency SOS link not found")
        emergencyLink.tap()
    }
    
    /// Checks if Settings > Exposure Notifications is available
    func testSettingsTopLevelExposureNotificationsIsRendered() throws {
        try XCTSkipIf(true, "Exposure Notifications not implemented")
    }
    
    /// Checks if Settings > Apps > FaceTime is available
    func testSettingsTopLevelFaceTimeIsRendered() {
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
        
        let faceTimeLink = app.buttons["FaceTime"]
        XCTAssertTrue(faceTimeLink.exists, "FaceTime link not found")
        faceTimeLink.tap()
    }
    
    /// Checks if Settings > Focus is available
    func testSettingsTopLevelFocusIsRendered() {
        let app = XCUIApplication()
        app.launch()
        
        let focusLink = app.buttons["com.apple.settings.focus"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !focusLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(focusLink.exists, "Focus link not found")
        focusLink.tap()
    }
    
    /// Checks if Settings > Apps > Freeform is available
    func testSettingsTopLevelFreeformIsRendered() {
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
        
        let freeformLink = app.buttons["Freeform"]
        XCTAssertTrue(freeformLink.exists, "Freeform link not found")
        freeformLink.tap()
    }
    
    /// Checks if Settings > General is available
    func testSettingsTopLevelGeneralIsRendered() {
        let app = XCUIApplication()
        app.launch()
        
        let generalLink = app.buttons["com.apple.settings.general"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !generalLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(generalLink.exists, "General link not found")
        generalLink.tap()
    }
    
    /// Checks if Settings > Apps > Health is available
    func testSettingsTopLevelHealthIsRendered() {
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
        
        let healthLink = app.buttons["Health"]
        swipeCount = 0
        
        while !healthLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(healthLink.exists, "Health link not found")
        healthLink.tap()
    }
    
    /// Checks if Settings > Home Screen & App Library is available
    func testSettingsTopLevelHomeScreenIsRendered() {
        let app = XCUIApplication()
        app.launch()
        
        let homeScreenLink = app.buttons["com.apple.settings.homeScreen"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !homeScreenLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(homeScreenLink.exists, "Home Screen & App Library link not found")
        homeScreenLink.tap()
    }
    
    /// Checks if Settings > Internal Settings is available
    func testSettingsTopLevelInternalSettingsIsRendered() throws {
        try XCTSkipIf(true, "Not implemented")
    }
    
    /// Checks if Settings > Apps > Mail is available
    func testSettingsTopLevelMailIsRendered() {
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
        
        let mailLink = app.buttons["Mail"]
        swipeCount = 0
        
        while !mailLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(mailLink.exists, "Mail link not found")
        mailLink.tap()
    }
    
    /// Checks if Settings > Apps > Maps is available
    func testSettingsTopLevelMapsIsRendered() {
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
        
        let mapsLink = app.buttons["Maps"]
        swipeCount = 0
        
        while !mapsLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(mapsLink.exists, "Maps link not found")
        mapsLink.tap()
    }
    
    /// Checks if Settings > Apps > Measure is available
    func testSettingsTopLevelMeasuresIsRendered() {
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
        
        let measureLink = app.buttons["Measure"]
        swipeCount = 0
        
        while !measureLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(measureLink.exists, "Measure link not found")
        measureLink.tap()
    }
    
    /// Checks if Settings > Apps > Messages is available
    func testSettingsTopLevelMessagesIsRendered() {
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
        
        let messagesLink = app.buttons["Messages"]
        swipeCount = 0
        
        while !messagesLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(messagesLink.exists, "Messages link not found")
        messagesLink.tap()
    }
    
    /// Checks if Settings > Apps > Music is available
    func testSettingsTopLevelMusicIsRendered() {
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
        
        let musicLink = app.buttons["Music"]
        swipeCount = 0
        
        while !musicLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(musicLink.exists, "Music link not found")
        musicLink.tap()
    }
    
    /// Checks if Settings > Apps > Notes is available
    func testSettingsTopLevelNotesIsRendered() {
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
        
        let notesLink = app.buttons["Notes"]
        swipeCount = 0
        
        while !notesLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(notesLink.exists, "Notes link not found")
        notesLink.tap()
    }
    
    /// Checks if Settings > Notifications is available
    func testSettingsTopLevelNotificationsIsRendered() {
        let app = XCUIApplication()
        app.launch()
        
        let notificationsLink = app.buttons["com.apple.settings.notifications"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !notificationsLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(notificationsLink.exists, "Apps link not found")
        notificationsLink.tap()
    }
    
    /// Checks if Settings > Apps > Photos is available
    func testSettingsTopLevelPhotosIsRendered() {
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
        
        let photosLink = app.buttons["Photos"]
        swipeCount = 0
        
        while !photosLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(photosLink.exists, "Photos link not found")
        photosLink.tap()
    }
    
    /// Checks if Settings > Apps > Podcasts is available
    func testSettingsTopLevelPodcastsIsRendered() {
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
        
        let podcasts = app.buttons["Podcasts"]
        swipeCount = 0
        
        while !podcasts.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(podcasts.exists, "Podcasts link not found")
        podcasts.tap()
    }
    
    /// Checks if Settings > Privacy & Security is available
    func testSettingsTopLevelPrivacyIsRendered() {
        let app = XCUIApplication()
        app.launch()
        
        let privacyLink = app.buttons["com.apple.settings.privacySecurity"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !privacyLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(privacyLink.exists, "Privacy & Security link not found")
        privacyLink.tap()
    }
    
    /// Checks if Settings > Apps > Reminders is available
    func testSettingsTopLevelRemindersIsRendered() {
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
        
        let remindersLink = app.buttons["Reminders"]
        swipeCount = 0
        
        while !remindersLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(remindersLink.exists, "Reminders link not found")
        remindersLink.tap()
    }
    
    /// Checks if Settings > Apps > Safari is available
    func testSettingsTopLevelSafariIsRendered() {
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
        
        let safariLink = app.buttons["Safari"]
        swipeCount = 0
        
        while !safariLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(safariLink.exists, "Safari link not found")
        safariLink.tap()
    }
    
    /// Checks if Settings > Screen Time is available
    func testSettingsTopLevelScreenTimeIsRendered() {
        let app = XCUIApplication()
        app.launch()
        
        let screenTimeLink = app.buttons["com.apple.settings.screenTime"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !screenTimeLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(screenTimeLink.exists, "Screen Time link not found")
        screenTimeLink.tap()
    }
    
    /// Checks if Settings search is available
    func testSettingsTopLevelSearchPaneIsRendered() {
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "Search field not found")
        searchField.tap()
    }
    
    /// Checks if Settings > Apps > Shortcuts is available
    func testSettingsTopLevelShortcutsIsRendered() {
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
        
        let shortcutsLink = app.buttons["Shortcuts"]
        swipeCount = 0
        
        while !shortcutsLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(shortcutsLink.exists, "Shortcuts link not found")
        shortcutsLink.tap()
    }
    
    /// Checks if Settings > Siri or Settings > Apple Intelligence & Siri is available
    func testSettingsTopLevelSiriIsRendered() {
        let app = XCUIApplication()
        app.launch()
        
        let siriLink = app.buttons["com.apple.settings.siri"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !siriLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(siriLink.exists, "Siri link not found")
        siriLink.tap()
    }
    
    /// Checks if Settings > Apps > Stocks is available
    func testSettingsTopLevelStocksIsRendered() {
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
        
        let stocksLink = app.buttons["Stocks"]
        swipeCount = 0
        
        while !stocksLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(stocksLink.exists, "Stocks link not found")
        stocksLink.tap()
    }
    
    /// Checks if Settings > Apps > Translate is available
    func testSettingsTopLevelTranslateIsRendered() {
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
        
        let translateLink = app.buttons["Translate"]
        swipeCount = 0
        
        while !translateLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(translateLink.exists, "Translate link not found")
        translateLink.tap()
    }
    
    /// Checks if Settings > Apps > TV is available
    func testSettingsTopLevelVideosIsRendered() throws {
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
        
        let tvLink = app.buttons["TV"]
        swipeCount = 0
        
        while !tvLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(tvLink.exists, "TV link not found")
        tvLink.tap()
    }
    
    /// Checks if Settings > Apps > Voice Memos is available
    func testSettingsTopLevelVoiceMemosIsRendered() {
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
        
        let voiceMemosLink = app.buttons["Voice Memos"]
        swipeCount = 0
        
        while !voiceMemosLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(voiceMemosLink.exists, "Voice Memos link not found")
        voiceMemosLink.tap()
    }
    
    /// Checks if Settings > Wallpaper is available
    func testSettingsTopLevelWallpaperIsRendered() {
        let app = XCUIApplication()
        app.launch()
        
        let wallpaperLink = app.buttons["com.apple.settings.wallpaper"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !wallpaperLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(wallpaperLink.exists, "Wallpaper link not found")
        wallpaperLink.tap()
    }
    
    /// Checks if Settings > Apps > Weather is available
    func testSettingsTopLevelWeatherIsRendered() {
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
        
        let weatherLink = app.buttons["Weather"]
        swipeCount = 0
        
        while !weatherLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(weatherLink.exists, "Weather link not found")
        weatherLink.tap()
    }
    
    /// Checks if Settings > Wi-Fi is available
    func testSettingsTopLevelWifiIsRendered() {
        let app = XCUIApplication()
        app.launch()
        
        let wifiLink = app.buttons["com.apple.settings.wifi"]
        let list = UIDevice.current.userInterfaceIdiom == .pad
            ? app.collectionViews["Sidebar"].firstMatch
            : app.collectionViews.firstMatch
        var swipeCount = 0
        
        while !wifiLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(wifiLink.exists, "Wi-Fi link not found")
        wifiLink.tap()
    }
    
    /// Checks if Settings > Apps > Books is available
    func testSettingsTopLeveliBooksIsRendered() {
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
        
        let booksLink = app.buttons["Books"]
        swipeCount = 0
        
        while !booksLink.exists && swipeCount < 10 {
            list.swipeUp()
            swipeCount += 1
        }
        XCTAssertTrue(booksLink.exists, "Books link not found")
        booksLink.tap()
    }
}
