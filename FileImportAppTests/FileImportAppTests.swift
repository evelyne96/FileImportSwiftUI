//
//  FileImportAppTests.swift
//  FileImportAppTests
//
//  Created by Suto, Evelyne on 09/05/2021.
//

import XCTest
@testable import FileImportApp

class FileImportAppTests: XCTestCase {
    
    func testRandomColorGeneration_WhenCalledWithTheSameString_GivesSameResult() throws {
        let testString = "Test"
        
        let firstColor = UIColor.random(with: testString)
        let secondColor = UIColor.random(with: testString)
        
        XCTAssertEqual(firstColor, secondColor)
    }
}
