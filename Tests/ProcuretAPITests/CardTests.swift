//
//  CardTests.swift
//  
//
//  Created by Kayla Hoyet on 5/2/22.
//

import XCTest
@testable import ProcuretAPI

class CardTests: XCTestCase {
    
    func testCreateCard() {
        
        let expectation = XCTestExpectation(
            description: "create Credit Card"
        )
        
        func receiveCardCreateResult(error: Error?, card: Card?) {
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(card, "Credit card is nil.")
            
            expectation.fulfill()
            return
        }
        
        Card.createFromPlainDetails(
            entityId: 7063459056099762,
            authorityAgentId: 100,
            cardNumber: "4242424242424242",
            expiryMonth: "12",
            expiryYear: "25",
            cvc: "424",
            postalCode: "42424",
            session: Session.forceFromEnvironmentVariables(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: receiveCardCreateResult
        )
        
        wait(for: [expectation], timeout: 5.0)
        return
    }
}
