//
//  AnalyticsTest.swift
//  FileImportAppTests
//
//  Created by Evelyne Suto on 01.02.2023.
//

import XCTest

class MockClient: AnalyticsClient {
    enum Calls: Equatable {
        case start
        case track(description: String, properties: [String: String]?)
    }
    
    private(set) var calls = [Calls]()
    
    func start() {
        calls.append(.start)
    }
    
    func track(_ description: String, properties: [String : String]?) {
        calls.append(.track(description: description, properties: properties))
    }
}

final class AnalyticsTest: XCTestCase {
    private var sut: AppAnalytics!
    private var mockClient: MockClient!
    
    override func setUp() {
        sut = AppAnalytics()
        mockClient = MockClient()
        sut.start(with: mockClient)
    }
    
    override func tearDown() {
        sut.stop()
        sut = nil
        mockClient = nil
    }
    
    func testClientStart() throws {
        XCTAssertEqual(mockClient.calls, [.start])
    }
    
    func testAnalytics_WhenEventTrackCalled_DelegatesCallToClientWithCorrectParameters() throws {
        let event: AppAnalytics.Event = .fileExported(type: .obj)
        let expectedCalls: [MockClient.Calls] = [.start,
                                                 .track(description: event.description, properties: event.properties)]
        
        sut.track(.fileExported(type: .obj))
        XCTAssertEqual(mockClient.calls, expectedCalls)
    }
}
