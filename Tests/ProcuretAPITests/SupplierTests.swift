//
//  SupplierTests.swift
//  ProcuretAPITests
//
//  Created by Kayla Hoyet on 9/28/21.
//

import XCTest
@testable import ProcuretAPI

class SupplierTests: XCTestCase {
    
    func testRetrieveSupplier() {
        
        let expectation = XCTestExpectation(description: "retrieve Supplier")
        
        func recieveSupplier(error: Error?, supplier: Supplier?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(supplier, "Supplier is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Utility.provideTestSupplier(
            expectation: expectation
        ) { supplier in
            Supplier.retrieve(
                supplierId: supplier.entity.publicId,
                session: Utility.provideTestSession(),
                endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
                callback: recieveSupplier
            )
            
            return
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}
