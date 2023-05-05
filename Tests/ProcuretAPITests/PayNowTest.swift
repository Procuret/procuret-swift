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
            
            Utility.provideTestBusiness(
                expectation: expectation
            ) { business, session in
                
                Utility.provideTestBankAccount(
                    expectation: expectation
                ) { account in
                    
                    /* Temporarily disabled */
                    
                    /*PayNowTransaction.create(
                        authenticatedBy: session,
                        amount: Amount(
                            magnitude: Decimal(string: "100")!,
                            denomination: .AUD
                        ),
                        reference: "pay now test",
                        business: business,
                        supplier: supplier,
                        divisions: ProspectiveDivision(
                            methodId: account.paymentMethodId,
                            magnitude: "100"
                        ),
                        at: .forceFromEnvironmentVariables(),
                        then: receivePayNowResults
                    )*/
                }
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}
