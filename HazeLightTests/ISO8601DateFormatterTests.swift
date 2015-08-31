//
//  ISO8601DateFormatterTests.swift
//  HazeLight
//
//  Created by Jon Shier on 8/30/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import XCTest

@testable
import HazeLight

class ISO8601DateFormatterTests: XCTestCase {
    func testDateFromString() {
        let dateString = "2014-05-28T18:46:18.764425Z"
        if let date = ISO8601DateFormatter.dateFromString(dateString) {
            XCTAssertTrue(date.description == "2014-05-28 18:46:18 +0000", "Date should be properly parse.")
        }
        else {
            XCTFail("ISO8601DateFormatter should parse CloudFlare date string.")
        }
    }
}
