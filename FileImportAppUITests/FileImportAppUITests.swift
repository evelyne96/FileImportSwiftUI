//
//  FileImportAppUITests.swift
//  FileImportAppUITests
//
//  Created by Suto, Evelyne on 09/05/2021.
//

import XCTest

extension XCUIElement {
    @discardableResult
    func wait(timeout: TimeInterval = 5) -> Bool {
        waitForExistence(timeout: timeout)
    }
}

class FileImportAppUITests: XCTestCase {
    private var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        
        super.tearDown()
    }
    
    func testPlusButtonExists() throws {
        let button = app.buttons[AccessabilityID.plusButton.rawValue]
        XCTAssertTrue(button.wait(), "Plus button does not exist")
    }
    
    func testPlusButtonOpensShareSheet() throws {
        let button = app.buttons[AccessabilityID.plusButton.rawValue]
        XCTAssertTrue(button.wait(), "Plus button does not exist")
        button.tap()
        
        let label = app.staticTexts.element(matching: .any, identifier: "Shared")
        XCTAssertTrue(label.wait(), "Shared label does not exist on share sheet")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
