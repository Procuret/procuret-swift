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
                authenticatedBy: Utility.provideTestSession(),
                at: ApiEndpoint.forceFromEnvironmentVariables(),
                then: recieveSupplier
            )
            
            return
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testCreateSupplier() {
        
        let expectation = XCTestExpectation(description: "create Supplier")
        
        Utility.provideTestEntity(
            expectation: expectation
        ) { entity, session in
         
            Supplier.create(
                authenticatedBy: session,
                entity: entity,
                at: .forceFromEnvironmentVariables()
            ) { error, supplier in
                
                XCTAssertNil(error)
                XCTAssertNotNil(supplier)
                
                expectation.fulfill()
                
                return

            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)

        return
        
    }

}
