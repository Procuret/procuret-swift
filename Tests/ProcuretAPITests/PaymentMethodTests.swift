//
//  PaymentMethodTests.swift
//  
//
//  Created by Kayla Hoyet on 2/15/22.
//

import XCTest
@testable import ProcuretAPI

class PaymentMethodTests: XCTestCase {
    
    func testRetrieveManyPaymentMethod() {
        
        let expectation = XCTestExpectation(
            description: "retrieveMany Payment Method"
        )
        
        func recieveManyPaymentMethod(
            error: Error?,
            methods: Array<PaymentMethod>?
        ) {
            
            XCTAssertNil(error)
            XCTAssertNotNil(methods)
            XCTAssert(methods?.count ?? 0 > 0)

            expectation.fulfill()
            
            return
        }
        
        PaymentMethod.retrieveMany(
            session: Session.forceFromEnvironmentVariables(),
            limit: 5,
            offset: 0,
            order: Order.descending,
            orderBy: PaymentMethod.OrderBy.created,
            callback: recieveManyPaymentMethod
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}

