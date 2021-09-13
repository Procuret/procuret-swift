//
//  BasicTests.swift
//
//
//  Created by Hugh Jeremy on 7/9/21.
//
import XCTest
@testable import ProcuretAPI

final class HumanTests: XCTestCase {
    
    func testRetrieveHuman() {
        
        let expectation = XCTestExpectation(description: "retrieve Human")
        
        func recieveHuman(error: Error?, human: Human?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(human, "Human is nil.")
            
            expectation.fulfill()
        }
        
        Human.retrieve(
            humanId: "60089808232490860", // some valid humanId
            session: nil,
            callback: recieveHuman
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }
}
