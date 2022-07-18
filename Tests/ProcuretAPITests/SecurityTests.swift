//
//  SecurityTests.swift
//  ProcuretAPITests
//
//  Created by Kayla Hoyet on 10/12/21.
//

import XCTest
@testable import ProcuretAPI

final class SecurityTests: XCTestCase {
    
    func provideSecret() -> String {
        
        do {
            return try SecondFactorCode.fromEnvironmentVariables()
        } catch {
            fatalError("Unable to return secret: \(error)")
        }
    }

    func testCreateSecondFactor() {
        
        let expectation = XCTestExpectation(description: "create Second Factor Code")
        
        func checkForError(error: Error?) {
            
            XCTAssertNil(error, "An error occurred.")
            
            expectation.fulfill()
            
            return
        }
        
        SecondFactorCode.create(
            email: "kayla.h@procuret.com", 
            secret: provideSecret(),
            perspective: nil,
            callback: checkForError
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
    
    func testSendResetRequest() {
        
        let expectation = XCTestExpectation()
        
        SecretResetRequest.create(
            email: "someone@procuret-test-domain.org",
            callback: { error in
                XCTAssertNil(error)
                expectation.fulfill()
            }
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
}
