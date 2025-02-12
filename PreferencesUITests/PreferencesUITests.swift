//
//  PreferencesUITests.swift
//  PreferencesUITests
//

import XCTest

final class PreferencesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // MARK: Interact with Search text field
        let searchField = app.navigationBars.searchFields["Search"]
        XCTAssertTrue(searchField.exists, "Search field does not exist")
        searchField.tap()
        searchField.typeText("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
        let cancelButton = app.buttons["Cancel"]
        cancelButton.firstMatch.tap()
        
        // MARK: Interact with SettingsLink buttons
        let buttons = ["Wi-Fi", "Bluetooth", "Cellular", "Battery", "General", "Accessibility", "Action Button", "Apple Intelligence & Siri", "Camera", "Control Center"]
        
        for button in buttons {
            let btn = app.buttons[button.localize(table: "Localizable")]
            if !btn.exists {
                XCTAssertTrue(btn.exists, "\(button) does not exist")
            }
            btn.tap()
            app.navigationBars.buttons.element(boundBy: 0).tap()
        }
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
