//
//  PayNowTest.swift
//  
//
//  Created by Kayla Hoyet on 5/3/23.
//

import XCTest
@testable import ProcuretAPI

class PayNowTest: XCTestCase {
    
    func testMakePayNowAttempt() {
        
        let expectation = XCTestExpectation(
            description: "make pay now attempt"
        )
        
        func receivePayNowResults(
            error: Error?,
            payNow: PayNowTransaction?
        ) {
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(payNow, "PayNow is nil.")
            
            expectation.fulfill()
                
            return
        }
        
        Utility.provideTestSupplier(
            expectation: expectation
        ) { supplier in
            
            SupplierAuthorisation.create(
                supplierId: supplier.entity.publicId,
                authorise: true,
                session: Utility.provideTestSession(),
                endpoint: .forceFromEnvironmentVariables()
            ) { _ in
                
                Utility.provideTestBusiness(
                    expectation: expectation
                ) { business, session in
                    
                    Utility.provideTestCard(
                        expectation: expectation,
                        entity: business.entity,
                        authority: session,
                        session: session
                    ) { card in
                        
                        PayNowTransaction.create(
                            authenticatedBy: session,
                            amount: Amount(
                                magnitude: Decimal(string: "100")!,
                                denomination: .AUD
                            ),
                            reference: "pay now test",
                            business: business,
                            supplier: supplier,
                            method: card,
                            at: .forceFromEnvironmentVariables(),
                            then: receivePayNowResults
                        )
                    
                    }
                }
    
            }
           
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}
