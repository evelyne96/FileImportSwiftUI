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
}
