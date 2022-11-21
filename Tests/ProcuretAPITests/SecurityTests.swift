//
//  SecurityTests.swift
//  ProcuretAPITests
//
//  Created by Kayla Hoyet on 10/12/21.
//

import XCTest
@testable import ProcuretAPI

final class SecurityTests: XCTestCase {

    func testCreateSecondFactor() {
        
        let expectation = XCTestExpectation(description: "create 2FA Code")
        
        Utility.provideTestHuman(
            expectation: expectation
        ) { human, secret, code in
            SecondFactorCode.create(
                email: human.emailAddress.rawEmailString,
                secret: secret,
                perspective: nil,
                endpoint: ApiEndpoint.forceFromEnvironmentVariables()
            ) { error in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
    func testRefreshSession() {
        
        let expectation = XCTestExpectation(description: "Refresh Session")
        
        Utility.provideTestHumanWithSession(
            expectation: expectation
        ) { human, session in
            
            session.refresh(
                endpoint: ApiEndpoint.forceFromEnvironmentVariables()
            ) { error, refreshedSession in
                
                XCTAssertNil(error)
                XCTAssertNotNil(refreshedSession)
                XCTAssertEqual(refreshedSession?.sessionId, session.sessionId)
                
                expectation.fulfill()
                
                return

            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    
    func testSendResetRequest() {
        
        let expectation = XCTestExpectation()
        
        SecretResetRequest.create(
            email: "someone@procuret-test-domain.org",
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: { error in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
}
