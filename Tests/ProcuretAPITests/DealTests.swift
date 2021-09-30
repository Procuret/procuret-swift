//
//  DealTests.swift
//  ProcuretAPITests
//
//  Created by Kayla Hoyet on 9/29/21.
//

import XCTest
@testable import ProcuretAPI

class DealTests: XCTestCase {

    func provideTestSession() -> Session {
        
        do {
            return try Session.fromEnvironmentVariables()
        } catch {
            fatalError("Unable to initalise test session: \(error)")
        }
    }
    
    func testRetrieveDeal() {
        
        let expectation = XCTestExpectation(description: "retrieve Deal")
        
        func recieveDeal(error: Error?, deal: Deal?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(deal, "Deal is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Deal.retrieve(
            commitmentId: "iXviBZSHjaZmdBen", // some valid commitmentId
            session: provideTestSession(),
            callback: recieveDeal
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}
