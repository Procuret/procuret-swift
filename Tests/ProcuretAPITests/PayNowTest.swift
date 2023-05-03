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
                methodId: series.paymentMethod.paymentMethodId,
                amount: line.nominalPayment,
                reference: "test pay now",
                businessId: String(series.customer.entityId),
                supplierId: String(series.supplier.entityId),
                session: session,
                callback: receivePayNowResults
            )
        }
        
        func receivePaymentSeries(error: Error?, series: PaymentSeries?) -> Void {
            
            XCTAssertNil(error)
            XCTAssertNotNil(series)
            
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
            
            PaymentSeries.retrieve(
                session: session,
                publicId: many[0].publicId,
                endpoint: .forceFromEnvironmentVariables(),
                callback: receivePaymentSeries
            )
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}
