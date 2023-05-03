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
        
        let session = Session.forceFromEnvironmentVariables()
        
        func receivePayNowResults(
            error: Error?,
            payNow: PayNowTransaction?
        ) {
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(payNow, "PayNow is nil.")
            
            expectation.fulfill()
                
            return
        }
        
        func createPayNowAttempt(
            for line: DealLedgerLine,
            inSeries series: PaymentSeries
        ) {
            PayNowTransaction.create(
                amount: line.nominalPayment,
                reference: "test pay now",
                businessId: series.customer.entityId,
                supplierId: series.supplier.entityId,
                divisions: ProspectiveDivision(
                    methodId: series.paymentMethod.publicId,
                    magnitude: series.amount.rawMagnitude
                ),
                session: session,
                endpoint: .forceFromEnvironmentVariables()
            ) { error, payNow in
                
                if let error = error {
                    XCTFail(error.localizedDescription)
                }

                expectation.fulfill()
                return
            }
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
