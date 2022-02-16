//
//  PaymentMethodTests.swift
//  
//
//  Created by Kayla Hoyet on 2/15/22.
//

import XCTest
@testable import ProcuretAPI

class PaymentMethodTests: XCTestCase {

    func provideTestSession() -> Session {
        
        do {
            return try Session.fromEnvironmentVariables()
        } catch {
            fatalError("Unable to initalise test session: \(error)")
        }
    }
    
    func testRetrieveManyPaymentMethod() {
        
        let expectation = XCTestExpectation(description: "retrieveMany Payment Method")
        
        func recieveManyPaymentMethod(error: Error?, paymentMethod: Array<PaymentMethod>?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(paymentMethod, "Payment Method is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        PaymentMethod.retrieveMany(
            limit: 5,
            offset: 1,
            order: Order.descending,
            orderBy: PaymentMethod.OrderBy.created,
            entityId: nil,
            authorityId: nil,
            active: nil,
            instrument: nil,
            processor: nil,
            session: provideTestSession(),
            callback: recieveManyPaymentMethod
        )
        
        wait(for: [expectation], timeout: 5.0)
    }
}

