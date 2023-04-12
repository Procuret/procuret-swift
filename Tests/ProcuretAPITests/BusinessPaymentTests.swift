//
//  BusinessPaymentTests.swift
//  
//
//  Created by Kayla Hoyet on 4/11/23.
//

import XCTest
@testable import ProcuretAPI

class BusinessPaymentsTest: XCTestCase {
    
    func testRetriveBusinessPayments() {
        
        let expectation = XCTestExpectation(
            description: "retrieve many payments"
        )
        
        func receiveResponse(
            error: Error?,
            payments: Array<BusinessPayment>?
        ) {
            XCTAssertNil(error)
            XCTAssertNotNil(payments)
            XCTAssert(payments?.count ?? 0 > 0)

            expectation.fulfill()
            return
        }
        
        Utility.provideTestBusiness(
            expectation: expectation
        ) { business in
            
            BusinessPayment.retrieveMany(
                limit: 5,
                offset: 0,
                order: Order.descending,
                orderBy: BusinessPayment.OrderBy.created,
                textFragment: nil,
                businessId: business.entity.id,
                methodId: nil,
                session: Utility.provideTestSession(),
                endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
                callback: receiveResponse
            )
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}
