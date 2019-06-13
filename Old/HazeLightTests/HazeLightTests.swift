//
//  HazeLightTests.swift
//  HazeLightTests
//
//  Created by Jon Shier on 8/9/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

@testable import HazeLight
import XCTest

class HazeLightTests: XCTestCase {
    func testObservableMapping() {
        // Given
        var firstValue: String?
        var secondValue: Int?
        let observer = NotificationObservable<String>()
        var firstToken: NotificationToken? = observer.observe { firstValue = $0 }
        let mappedObserver = observer.map(Int.init)
        let expect = expectation(description: "observer should fire")
        var secondToken: NotificationToken? = mappedObserver.observe { secondValue = $0; expect.fulfill() }
        
        // When
        observer.updateValue(with: "10")
        
        waitForExpectations(timeout: 1, handler: nil)
        
        if firstToken != nil { firstToken = nil }
        if secondToken != nil { secondToken = nil }
        
        // Then
        XCTAssertEqual(firstValue, "10")
        XCTAssertEqual(secondValue, 10)
    }
}
