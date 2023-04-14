//
//  InstalmentAttemptTest.swift
//  
//
//  Created by Kayla Hoyet on 4/14/23.
//

import XCTest
@testable import ProcuretAPI

class InstalmentAttemptTest: XCTestCase {
    
    func testMakeInstalmentAttempt() {
        let expectation = XCTestExpectation(
            description: "make instalment payment attempt"
        )
        
        func receiveInstalmentAttemptResults(
            error: Error?,
            outcome: InstalmentPaymentAttempt.Outcome?
        ) {
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(outcome, "Outcome is nil.")
            
            expectation.fulfill()
                
            return
        }
        
        Utility.provideTestSeries(
            expectation: expectation
        ) { series in
            InstalmentPaymentAttempt.make(
                methodId: series.paymentMethod.paymentMethodId,
                seriesId: series.id,
                amount: Amount(
                    magnitude: 5.0,
                    denomination: Currency.AUD
                ),
                due24hrsStarting: Date.now,
                session: Session.forceFromEnvironmentVariables(),
                endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
                callback: receiveInstalmentAttemptResults
            )
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}


