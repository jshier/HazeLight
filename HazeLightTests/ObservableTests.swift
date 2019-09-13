//
//  ObservableTests.swift
//  HazeLightTests
//
//  Created by Jon Shier on 7/31/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

@testable
import HazeLight

import Alamofire
import Combine
import XCTest

final class ObservableTests: XCTestCase {
    var cancellables: [AnyCancellable] = []
    
    override func tearDown() {
        super.tearDown()

        cancellables = []
    }
    
    func testNetworkValue() {
        // Given
        let value = NetworkValue<String>()
        let resultExpect = expectation(description: "should receive new Result")
        let valueExpect = expectation(description: "should receive new value")
        let sent = "sent"
        
        // When
        cancellables = [
            value.$result.sink { (result) in
                resultExpect.fulfill()
            },
            value.$value.sink { (value) in
                valueExpect.fulfill()
            }
        ]

        value.result = .success(sent)
        
        waitForExpectations(timeout: 1)
        
        // Then
//        XCTAssertEqual(value.result, .success(sent))
        XCTAssertEqual(value.value, sent)
    }
    
//    var cancellable: AnyCancellable?
//    var cancellables: [AnyCancellable] = []
//
//    override func tearDown() {
//        super.tearDown()
//
//        cancellable = nil
//        cancellables = []
//    }
//
//    func testOptionalValueSubjectWorks() {
//        // Given
//        let subject = OptionalValueSubject<String, Never>()
//        let expect = expectation(description: "received value")
//        expect.expectedFulfillmentCount = 5
//        var received: [String] = []
//
//        // When
//        cancellable = subject.sink {
//            received.append($0)
//            expect.fulfill()
//        }
//        subject.send("1")
//        subject.send("2")
//        subject.send("3")
//        subject.send("4")
//        subject.send("5")
//
//        waitForExpectations(timeout: 1)
//
//        // Then
//        XCTAssertEqual(["1", "2", "3", "4", "5"], received)
//    }
//
//    func testThatNetworkValueWorks() {
//        // Given
//        struct HTTPBin: Decodable { let url: String }
//        let request = URLRequest(url: URL(string: "https://httpbin.org/get")!)
//        let networkValue = NetworkValue<HTTPBin>()
//        let requestCreation = expectation(description: "request created")
//        let requestNil = expectation(description: "request should be nil'd")
//        let response = expectation(description: "should receive response")
//        let result = expectation(description: "should receive result")
//        let value = expectation(description: "should receive value")
//        var receivedValue: HTTPBin?
//
//        // When
//        cancellables = [
//            networkValue.request.dropFirst().sink { request in
//                if request != nil {
//                    requestCreation.fulfill()
//                } else {
//                    requestNil.fulfill()
//                }
//            },
//            networkValue.response.sink { _ in response.fulfill() },
//            networkValue.result.sink { _ in result.fulfill() },
//            networkValue.value.sink { received in receivedValue = received; value.fulfill() }
//        ]
//        networkValue.update(using: request)
//
//        wait(for: [requestCreation, response, result, value, requestNil], timeout: 1, enforceOrder: true)
//
//        // Then
//        XCTAssertEqual(receivedValue?.url, "https://httpbin.org/get")
//        print(networkValue)
//    }
}
