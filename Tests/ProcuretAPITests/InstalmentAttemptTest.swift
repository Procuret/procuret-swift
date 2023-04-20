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
        
        func receiveSchedule(_ schedule: InstalmentSchedule, _ series: PaymentSeries) -> Void {
            
            for line in schedule.lines {
                if line.status == .overdue || line.status == .dueUnpaid {
                    makeAttempt(on: line, inSeries: series)
                    return
                }
                continue
            }
            
            XCTFail("No overdue / unpaidDue"); expectation.fulfill()
            
            return
    
        }
        
        func receiveSeries(_ series: PaymentSeries) -> Void {

            InstalmentSchedule.retrieve(
                seriesId: "uiK3ihKJvYtw",  // Temporary dev. hard code
                session: session,
                endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
                callback: { error, schedule in
                    
                    guard let schedule = schedule else {
                        XCTFail(error?.localizedDescription ?? "No error")
                        expectation.fulfill()
                        return
                    }
                    
                    receiveSchedule(schedule, series)
        
                    return
                    
                }
            )
            
            
        }
        
        PaymentSeries.retrieve(
            session: session,
            publicId: "uiK3ihKJvYtw",  // temporary dev hardcode
            endpoint: .forceFromEnvironmentVariables()
        ) { error, series in
            
            guard let series = series else {
                XCTFail("no Series"); expectation.fulfill(); return
            }
            
            receiveSeries(series)
            
            return

        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}


