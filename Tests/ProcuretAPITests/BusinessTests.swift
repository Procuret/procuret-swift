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
        
        let expectation = XCTestExpectation(
            description: "Create Business"
        )
        
        Utility.provideTestBusiness(
            expectation: expectation
        ) { _, _ in
            
            expectation.fulfill()
            
            return
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testCreateBusinessWithEntity() {
        
        let expectation = XCTestExpectation(
            description: "create business with entity")
        
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
                endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
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
    
    func testRetrieveBusiness() -> Void {
        
        let expectation = XCTestExpectation(description: "Retrieve a Business")
        
        Utility.provideTestBusiness(
            expectation: expectation,
            callback: { createdBusiness, session in
                
                Business.retrieve(
                    authenticatedBy: session,
                    for: createdBusiness.entity,
                    at: ApiEndpoint.forceFromEnvironmentVariables()
                ) { error, retrievedBusiness in
                    
                    XCTAssertNil(error)
                    XCTAssertNotNil(retrievedBusiness)
                    XCTAssert(
                        retrievedBusiness?.entity.publicId
                            == createdBusiness.entity.publicId
                    )
                    expectation.fulfill()
                    return
    
                }
                
            }
        )
        
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    
}
