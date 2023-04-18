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
        
        Utility.provideTestSchedule(
            expectation: expectation
        ) { schedule in
            
            Utility.provideTestSeries(
                expectation: expectation
            ) { series in
                
                let position: Int = 0
                
                InstalmentPaymentAttempt.make(
                    methodId: series.paymentMethod.paymentMethodId,
                    seriesId: schedule.seriesId,
                    amount: schedule.lines[position].nominalPayment,
                    due24hrsStarting: schedule.lines[position].due24hrsStarting,
                    session: Session.forceFromEnvironmentVariables(),
                    endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
                    callback: receiveInstalmentAttemptResults
                )
            }
        }

        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}


