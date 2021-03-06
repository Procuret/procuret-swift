//
//  BusinessTests.swift
//  ProcuretAPITests
//
//  Created by Kayla Hoyet on 10/29/21.
//

import XCTest
@testable import ProcuretAPI

class BusinessTests: XCTestCase {

    func provideTestSession() -> Session {
        
        do {
            return try Session.fromEnvironmentVariables()
        } catch {
            fatalError("Unable to initalise test session: \(error)")
        }
    }
    
    func testCreateBusiness() {
        
        let expectation = XCTestExpectation(description: "create Business")
        
        func createBusiness(error: Error?, business: Business?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(business, "Business is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Business.create(
            abn: "77630036789",
            address: AddressCreationStruct(
                line1: "47 Brighton Rd",
                line2: nil,
                line3: nil,
                line4: nil,
                postalCode: "4101",
                locality: "QLD",
                regionId: 1,
                countryId: 1),
            session: provideTestSession(),
            callback: createBusiness
        )
        
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}
