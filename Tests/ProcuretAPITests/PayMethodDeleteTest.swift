//
//  PayMethodDeleteTest.swift
//  
//
//  Created by Kayla Hoyet on 5/25/22.
//

import XCTest
@testable import ProcuretAPI

class PayMethodDeleteTest: XCTestCase {
    
    func testCreateDeleteDirectDebit() {

        let expectation = XCTestExpectation(
            description: "create then delete BECSDD payment method"
        )

        func receiveCreatedBecsDD(
            error: Error?,
            becsDirectDebit: BECSDirectDebit?
        ) {
            
            guard let becsDirectDebit = becsDirectDebit else {
                XCTFail("Unexpected nil BECS Direct Debit.")
                return
            }
            
            func checkDeletionSuccess(error: Error?) {
                XCTAssertNil(error, "An error occurred.")
                
                expectation.fulfill()
                return
            }
            
            PaymentMethod.delete(
                publicId: becsDirectDebit.publicId,
                session: Session.forceFromEnvironmentVariables(),
                endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
                callback: checkDeletionSuccess
            )
            
            return
    
        }
        
        // test will fail due to hard coded agent having no Stripe customer
        // record. Test should use a Human generated at runtime as the agent.
        
        BECSDirectDebit.create(
            bsbCode: "000000",
            accountNumber: "000123456",
            accountName: "Test DD",
            authorityAgentId: 100,
            timeMandateAccepted: Int(Date().timeIntervalSince1970),
            entityId: nil,
            mandateIp: "0.0.0.0",
            mandateAgent: "GarbageAgent",
            session: Session.forceFromEnvironmentVariables(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: receiveCreatedBecsDD
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }
}
