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
        
        Utility.provideTestBankAccount(
            expectation: expectation
        ) { bankAccount in
            
            expectation.fulfill()
            return
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }
}
        
