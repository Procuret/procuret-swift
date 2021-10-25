//
//  BasicTests.swift
//
//
//  Created by Hugh Jeremy on 7/9/21.
//
import XCTest
@testable import ProcuretAPI

final class HumanTests: XCTestCase {
    
    func provideTestSession() -> Session {
        
        do {
            return try Session.fromEnvironmentVariables()
        } catch {
            fatalError("Unable to initalise test session: \(error)")
        }
    }
    
    func provideTestEmail() ->  String {
        
        do {
            return TestEmail.generateEmail()
        }
    }
    
    func testRetrieveHuman() {
        
        let expectation = XCTestExpectation(description: "retrieve Human")
        
        func recieveHuman(error: Error?, human: Human?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(human, "Human is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Human.retrieve(
            humanId: 21949570389669501, // some valid humanId
            session: provideTestSession(),
            callback: recieveHuman
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testCreateHuman() {
        
        let expectation = XCTestExpectation(description: "create Human")
        
        func generateHuman(error: Error?, human: Human?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(human, "Human is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Human.create(
            firstName: "TestKayla",
            lastName: "Test",
            emailAddress: provideTestEmail(),
            phone: "+17654615534",
            secret: "sooper secret code",
            existingPhone: nil,
            verifyPhone: false,
            creationNote: nil,
            session: provideTestSession(),
            supplier: true,
            hasAgentSecret: false,
            signupPerspective: 1,
            callback: generateHuman
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
}
