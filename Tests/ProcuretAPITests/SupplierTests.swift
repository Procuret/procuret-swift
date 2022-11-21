//
//  SupplierTests.swift
//  ProcuretAPITests
//
//  Created by Kayla Hoyet on 9/28/21.
//

import XCTest
@testable import ProcuretAPI

class SupplierTests: XCTestCase {

    func provideTestSession() -> Session {
        
        do {
            return try Session.fromEnvironmentVariables()
        } catch {
            fatalError("Unable to initalise test session: \(error)")
        }
    }
    
    func testRetrieveSupplier() {
        
        let expectation = XCTestExpectation(description: "retrieve Supplier")
        
        func recieveSupplier(error: Error?, supplier: Supplier?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(supplier, "Supplier is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Supplier.retrieve(
            supplierId: 71205185107785336, // some valid supplierId
            session: provideTestSession(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: recieveSupplier
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}
