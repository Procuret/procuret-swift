// BECSDirectDebitTests.swift
//
//
// Created by Kayla Hoyet on 4/12/22.
//
import XCTest
@testable import ProcuretAPI

class BECSDirectDebitTests: XCTestCase {

    func testCreateBECSDirectDebit() {

        let expectation = XCTestExpectation(
            description: "create BECS Direct Debit"
        )

        func createBECSDirectDebit(error: Error?, becsDirectDebit:
            BECSDirectDebit?) {
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(becsDirectDebit, "BECS Direct Debit is nil.")
            
            expectation.fulfill()
            return
            
        }

        BECSDirectDebit.create(
            bsbCode: "000000",
            accountNumber: "000123456",
            accountName: "Kayla TestDD",
            authorityAgentId: 100,
            timeMandateAccepted: Int(Date().timeIntervalSince1970),
            entityId: nil,
            mandateIp: "0.0.0.0",
            mandateAgent: "GarbageAgent",
            session: Session.forceFromEnvironmentVariables(),
            callback: createBECSDirectDebit
        )
        
        wait(for: [expectation], timeout: 5.0)
        return
        
    }
}
