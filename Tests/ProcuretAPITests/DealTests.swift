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
        
        let expectation = XCTestExpectation()
        let session = Session.forceFromEnvironmentVariables()
        
        Deal.retrieveMany(
            limit: 5,
            offset: 1,
            order: Order.descending,
            orderBy: Deal.OrderBy.created,
            anyNameFragment: nil,
            session: Session.forceFromEnvironmentVariables(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables()
        ) { error, many in
            
            guard let many = many else {
                XCTFail(); expectation.fulfill()
                return
            }
            
            guard many.count > 0 else {
                XCTFail(); expectation.fulfill()
                return
            }
            
            Deal.retrieve(
                commitmentId: many[0].commitmentId,
                session: session,
                endpoint: ApiEndpoint.forceFromEnvironmentVariables()
            ) { error, deal in
                
                XCTAssertNotNil(deal)
                XCTAssertNil(error)
                
                expectation.fulfill()
                
                return
            }
        }
        
        wait(for: [expectation], timeout: 5)
        
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
        
        return
    }
}
