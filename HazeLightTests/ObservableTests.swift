//
//  ObservableTests.swift
//  HazeLightTests
//
//  Created by Jon Shier on 7/31/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

@testable
import HazeLight

import Combine
import XCTest

final class ObservableTests: XCTestCase {
    var cancellable: AnyCancellable?
    
    override func tearDown() {
        super.tearDown()
        
       cancellable = nil
    }
    
    func testOptionalValueSubjectWorks() {
        // Given
        let subject = OptionalValueSubject<String, Never>()
        let expect = expectation(description: "received value")
        let sent = "sent"
        var received: String?
        
        // When
        cancellable = subject.sink {
            received = $0
            expect.fulfill()
        }
        subject.send(sent)
        
        waitForExpectations(timeout: 1)
        
        // Then
        XCTAssertEqual(sent, received)
    }
    
    func testThatNetworkValueWorks() {
        // Given
    }
}
