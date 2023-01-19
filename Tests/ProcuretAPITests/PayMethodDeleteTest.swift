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
        
        Utility.provideTestEntity(
            expectation: expectation
        ) { entity, session in
            
            BECSDirectDebit.create(
                bsbCode: "000000",
                accountNumber: "000123456",
                accountName: "Becs Test",
                authorityAgentId: session.agentId,
                timeMandateAccepted: Int(Date().timeIntervalSince1970),
                entityId: entity.publicId,
                mandateIp: "0.0.0.0",
                mandateAgent: "GarbageAgent",
                session: session,
                callback: receiveCreatedBecsDD
            )
            
            return
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }
}
