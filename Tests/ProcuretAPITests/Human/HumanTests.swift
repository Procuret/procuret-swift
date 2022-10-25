//
//  BasicTests.swift
//
//
//  Created by Hugh Jeremy on 7/9/21.
//
import XCTest
@testable import ProcuretAPI

final class HumanTests: XCTestCase {
    
    
    func testRetrieveHuman() {
        
        let expectation = XCTestExpectation(description: "retrieve Human")
        
        func recieveHuman(error: Error?, human: Human?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(human, "Human is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Utility.provideTestHuman(
            expectation: expectation
        ) { human, secret, code in
            
            Human.retrieve(
                humanId: human.humanId,
                session: Utility.provideTestSession(),
                callback: recieveHuman
            )
            
            return
            
        }

        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testCreateHuman() {
        
        let expectation = XCTestExpectation(description: "create Human")
        
        Utility.provideTestHuman(
            expectation: expectation
        ) { human, secret, code in
            
            expectation.fulfill()
            
            return
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testCreateHumanIdentity() {
        
        let expectation = XCTestExpectation(description: "create Human Identity")
        
        func receiveHumanIdentity(error: Error?, self: HumanIdentity?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(self, "Human Identity is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Utility.provideTestHuman(
            expectation: expectation
        ) { human, secret, code in
            
            HumanIdentity.create(
                humanId: human.humanId,
                dateOfBirth: "1987-10-13",
                address: Address.CreationData(
                    line1: "44 Bridge Street",
                    line2: nil,
                    line3: nil,
                    line4: nil,
                    postalCode: "2000",
                    locality: "NSW",
                    regionId: 1,
                    countryId: 1),
                session: Utility.provideTestSession(),
                callback: receiveHumanIdentity
            )
            
            return

        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testCreateHumanIdentityDocument() {
        
        let expectation = XCTestExpectation(description:
            "create Human Identity Document")
        
        func receiveHumanIdentityDocument(error: Error?,
            self: HumanIdentityDocument?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(self, "Human Identity Document is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Utility.provideTestHuman(
            expectation: expectation
        ) { human, secret, code in
            
            HumanIdentityDocument.create(
                humanId: human.humanId,
                idDocumentType: 1,
                idDocumentIdentifier: "123456",
                session: Utility.provideTestSession(),
                callback: receiveHumanIdentityDocument
            )
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testNewHumanRequiresPhoneConfirmation() {
        
        let expectation = XCTestExpectation(
            description: "A newly created Human requires phone confirmation"
        )
        
        func receiveHuman(human: Human, secret: String, code: String) {
            
            if human.phone.confirmationRequired != true {
                XCTFail("Human phone does not require confirmation")
            }
            
            expectation.fulfill()
            
            return
            
        }
        
        Utility.provideTestHuman(
            expectation: expectation,
            callback: receiveHuman,
            verifyPhone: true
        )

        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }
    
    func testHumanAgentFromSession() {
        
        let expectation = XCTestExpectation(
            description: "Extract a Human agent from a Session"
        )
        
        func recieveSession(error: Error?, session: Session?) -> Void {
            
            XCTAssertNil(error)
            XCTAssertNotNil(session)
            XCTAssertNotNil(session?.human)
            
            expectation.fulfill()
            
            return

        }
        
        Utility.provideTestHuman(
            expectation: expectation
        ) { human, secret, code in
            Session.create(
                secret: secret,
                email: human.emailAddress.emailAddress,
                code: code,
                perspective: .business,
                callback: recieveSession
            )
            return
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }
    
}
