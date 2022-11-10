//
//  BusinessTests.swift
//  ProcuretAPITests
//
//  Created by Kayla Hoyet on 10/29/21.
//

import XCTest
@testable import ProcuretAPI

class BusinessTests: XCTestCase {

    func testCreateBusiness() {
        
        let expectation = XCTestExpectation(description: "create Business")
        
        func receiveResponse(error: Error?, business: Business?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(business, "Business is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Business.create(
            abn: "77630036789",
            address: Address.CreationData(
                line1: "47 Brighton Rd",
                line2: nil,
                line3: nil,
                line4: nil,
                postalCode: "4101",
                locality: "QLD",
                regionId: 1,
                countryId: 1),
            session: Utility.provideTestSession(),
            callback: receiveResponse
        )
        
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
    func testCreateBusinessWithEntity() {
        
        let expectation = XCTestExpectation(description: "create business")
        
        func receiveResponse(error: Error?, business: Business?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(business, "Business is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        func createBusiness(entity: Entity) {
            Business.create(
                entity: entity,
                session: Utility.provideTestSession(),
                callback: receiveResponse
            )
        }
        
        Utility.provideTestEntity(
            expectation: expectation,
            callback: createBusiness
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
    
}
