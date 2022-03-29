//
//  PaymentSeriesTest.swift
//  
//
//  Created by Kayla Hoyet on 3/9/22.
//

import XCTest
@testable import ProcuretAPI

class PaymentSeriesTest: XCTestCase {
    
    func testRetrieveManyPaymentSeries() {
        
        let expectation = XCTestExpectation(
            description: "retrieveMany Payment Series"
        )
        
        func recieveManyPaymentSeries(
            error: Error?,
            paymentSeries: Array<PaymentSeries>?
        ) {
            
            XCTAssertNil(error)
            XCTAssertNotNil(paymentSeries)
            
            expectation.fulfill()
            
            return
        }
        
        PaymentSeries.retrieveMany(
            session: Session.forceFromEnvironmentVariables(),
            callback: recieveManyPaymentSeries
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
    func testRetrievePaymentSeries() {
        
        let expectation = XCTestExpectation()
        let session = Session.forceFromEnvironmentVariables()
        
        PaymentSeries.retrieveMany(
            session: Session.forceFromEnvironmentVariables()
        ) { error, many in
            
            guard let many = many else {
                XCTFail(); expectation.fulfill()
                return
            }
            
            guard many.count > 0 else {
                XCTFail(); expectation.fulfill()
                return
            }
            
            PaymentSeries.retrieve(
                session: session,
                publicId: many[0].publicId
            ) { error, series in
                
                XCTAssertNotNil(series)
                XCTAssertNil(error)
                
                expectation.fulfill()
                
                return
                
            }
            
        }
        
        wait(for: [expectation], timeout: 5)
        
        return
        
    }
}
