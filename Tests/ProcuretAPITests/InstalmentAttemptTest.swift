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
        
        let session = Session.forceFromEnvironmentVariables()
        
        func receiveInstalmentAttemptResults(
            error: Error?,
            outcome: InstalmentPaymentAttempt.Outcome?
        ) {
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(outcome, "Outcome is nil.")
            
            expectation.fulfill()
                
            return
        }
        
        func makeAttempt(
            on line: DealLedgerLine,
            inSeries series: PaymentSeries
        ) {
            
            InstalmentPaymentAttempt.make(
                methodId: series.paymentMethod.publicId,
                seriesId: series.publicId,
                amount: line.nominalPayment,
                due24hrsStarting: line.due24hrsStarting,
                session: session,
                endpoint: .forceFromEnvironmentVariables()
            ) { error, outcome in
                
                if let error = error {
                    XCTFail(error.localizedDescription)
                }

                expectation.fulfill()
                return
                
            }
            
            return
            
        }
        
        func receiveSchedule(error: Error?, schedule: InstalmentSchedule?) -> Void {
            
            XCTAssertNil(error)
            XCTAssertNotNil(schedule)
            
            expectation.fulfill()
            
            return
    
        }
        
        PaymentSeries.retrieveMany(
            session: session,
            hasOverdueInstalement: true,
            endpoint: .forceFromEnvironmentVariables()
        ) { error, many in
            
            guard let many = many else {
                XCTFail("no series"); expectation.fulfill()
                return
            }
            
            InstalmentSchedule.retrieve(
                seriesId: many[0].publicId,
                session: session,
                endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
                callback: receiveSchedule
            )
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}


