//
//  BankAccountTests.swift
//  
//
//  Created by Kayla Hoyet on 4/7/22.
//

import XCTest
@testable import ProcuretAPI

class BankAccountTests: XCTestCase {
    
    
    func testCreateBankAccount() {
        
        let expectation = XCTestExpectation(
            description: "create Bank Account"
        )
        
        func generateBankAccount(error: Error?, bankAccount: BankAccount?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(bankAccount, "Bank Account is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        BankAccount.create(
            bsbCode: "123456",
            accountNumber: "987654321",
            accountName: "KaylaTest BankAccount",
            entityId: "13991055489669749",
            authorityId: nil,
            session: Session.forceFromEnvironmentVariables(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: generateBankAccount
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
}
        
