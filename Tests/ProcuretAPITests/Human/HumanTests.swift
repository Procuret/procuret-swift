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
        
        // Test Human.retrieve() here. Call .fulfill() on `expectation` when
        // testing is complete.
        
        // XCTestCase passes unless explicitly failed.
        
        // Use XCTAssertNil to fail the test if an expected nil variable (such
        // as an error) is not nil.
        
        // Use XCTAsserNotNil to fail the test if an expected non-nil variable
        // (such as the human) is nil.
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }

}
