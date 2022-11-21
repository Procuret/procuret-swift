//
//  DealTests.swift
//  ProcuretAPITests
//
//  Created by Kayla Hoyet on 9/29/21.
//
import XCTest
@testable import ProcuretAPI


class DealTests: XCTestCase {

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
            session: Utility.provideTestSession(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: recieveDeal
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }
    
    func testRetreieveManyDeal() {
        
        let expectation = XCTestExpectation(description: "retrieveMany Deal")
        
        func recieveManyDeal(error: Error?, deal: Array<Deal>?) {
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(deal, "Deal is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Deal.retrieveMany(
            limit: 5,
            offset: 1,
            order: Order.descending,
            orderBy: Deal.OrderBy.created,
            anyNameFragment: nil,
            session: Utility.provideTestSession(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: recieveManyDeal
        )
        
        wait(for: [expectation], timeout: 5.0)
    }
}
