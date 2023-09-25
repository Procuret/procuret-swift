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
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: recieveManyPaymentSeries
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
    func testRetrievePaymentSeries() {
        
        let expectation = XCTestExpectation()
        let session = Session.forceFromEnvironmentVariables()
        
        PaymentSeries.retrieveMany(
            session: Session.forceFromEnvironmentVariables(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables()
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
                publicId: many[0].publicId,
                endpoint: ApiEndpoint.forceFromEnvironmentVariables()
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
    
    /* Disabled pending availability of a .providePendingSeries utility
     method
    
    func testRetrieveManyPendingSeries() {
        
        let expectation = XCTestExpectation()
        
        func receivePendingResult(
            error: Error?,
            seriesPending: Array<PendingSeries>?
        ) {
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(seriesPending, "Pending series is nil.")
            XCTAssert(seriesPending?.count ?? 0 > 0)
            
            expectation.fulfill()
            return
        }
        
        Utility.provideTestSeries(  // Replace with "Pending Series"
            expectation: expectation
        ) { session, series in
            
            Business.retrieve(
                authenticatedBy: session,
                publicId: series.customer.entityId,
                at: ApiEndpoint.forceFromEnvironmentVariables()
            ) { error, business in
                
                PendingSeries.retrieveMany(
                    authenticatedBy: session,
                    business: business,
                    endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
                    callback: receivePendingResult
                )
                
                return
                
            }

            return
            
        }
        
        
        wait(for: [expectation], timeout: 5.0)
        return
                    
       
    }
     */

}
