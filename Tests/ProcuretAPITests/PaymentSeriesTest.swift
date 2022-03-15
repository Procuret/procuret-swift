//
//  PaymentSeriesTest.swift
//  
//
//  Created by Kayla Hoyet on 3/9/22.
//

import XCTest
@testable import ProcuretAPI

class PaymentSeriesTest: XCTestCase {
    
    func provideTestSession() -> Session {
        
        do {
            return try Session.fromEnvironmentVariables()
        } catch {
            fatalError("Unable to initalise test session: \(error)")
        }
    }
    
    func testRetrieveManyPaymentSeries() {
        
        let expectation = XCTestExpectation(description: "retrieveMany Payment Series")
        
        func recieveManyPaymentSeries(error: Error?, paymentSeries: Array<PaymentSeries>?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(paymentSeries, "Payment Series is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        PaymentSeries.retrieveMany(
            limit: 5,
            offset: 1,
            order: Order.descending,
            orderBy: PaymentSeriesOrderBy.created,
            textFragment: nil,
            businessId: nil,
            methodId: nil,
            session: provideTestSession(),
            callback: recieveManyPaymentSeries
        )
        
        wait(for: [expectation], timeout: 5.0)
    }
}
