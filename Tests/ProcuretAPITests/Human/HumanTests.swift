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
    
    func provideTestHuman(
        expectation: XCTestExpectation,
        callback: @escaping (
            _ human: Human,
            _ secret: String,
            _ code: String
        ) -> Void,
        verifyPhone: Bool = false,
        withEnvironmentSession: Bool = true
    ) {
        
        let dummySecret = RandomNumber(.large).string
        let email = provideTestEmail()
        
        let session: Session?
        
        if withEnvironmentSession {
            session = self.provideTestSession()
        } else {
            session = nil
        }
        
        Human.create(
            firstName: "SwiftTest",
            lastName: "TestAgent",
            emailAddress: email,
            phone: "+61400010001",
            secret: dummySecret,
            existingPhone: nil,
            verifyPhone: verifyPhone,
            creationNote: nil,
            session: session,
            hasAgentSecret: false,
            signupPerspective: .business,
            callback: { (error, human, code) in
                
                guard let human = human, let code = code else {
                    XCTFail("Unable to create test Human")
                    expectation.fulfill()
                    return
                }
                
                callback(human, dummySecret, code)
                
                return

            }
        )
        
        return
        
    }
    
    func testRetrieveHuman() {
        
        let expectation = XCTestExpectation(description: "retrieve Human")
        
        func recieveHuman(error: Error?, human: Human?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(human, "Human is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        Human.create(
            firstName: "TestKayla",
            lastName: "Test",
            emailAddress: provideTestEmail(),
            phone: "+61400010001",
            secret: "sooper secret code",
            existingPhone: nil,
            verifyPhone: false,
            creationNote: nil,
            session: provideTestSession(),
            hasAgentSecret: false,
            signupPerspective: .business,
            callback: { (error, human) in
                
                guard let human = human else {
                    XCTFail("Could not create target Human")
                    expectation.fulfill()
                    return
                }
                
                Human.retrieve(
                    humanId: human.humanId,
                    session: self.provideTestSession(),
                    callback: recieveHuman
                )
                
                return
            }
        )

        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testCreateHuman() {
        
        let expectation = XCTestExpectation(description: "create Human")
        
        func receiveHuman(error: Error?, human: Human?, code: String?) {
            
            XCTAssertNil(error, "An error occurred")
            XCTAssertNotNil(human, "Human is nil")
            XCTAssertNotNil(code, "2FA code is nil")
            
            expectation.fulfill()
            
            return
        }
        
        Human.create(
            firstName: "TestKayla",
            lastName: "Test",
            emailAddress: provideTestEmail(),
            phone: "+61400010001",
            secret: "sooper secret code",
            existingPhone: nil,
            verifyPhone: false,
            creationNote: nil,
            session: provideTestSession(),
            hasAgentSecret: false,
            signupPerspective: .business,
            callback: receiveHuman
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testCreateHumanIdentity() {
        
        let expectation = XCTestExpectation(description: "create Human Identity")
        
        func generateHumanIdentity(error: Error?, self: HumanIdentity?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(self, "Human Identity is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        HumanIdentity.create(
            humanId: "27144684924846194",
            dateOfBirth: "1987-10-13",
            address: AddressCreationStruct(
                line1: "44 Bridge Street",
                line2: nil,
                line3: nil,
                line4: nil,
                postalCode: "2000",
                locality: "NSW",
                regionId: 1,
                countryId: 1),
            session: provideTestSession(),
            callback: generateHumanIdentity
        )
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testCreateHumanIdentityDocument() {
        
        let expectation = XCTestExpectation(description:
            "create Human Identity Document")
        
        func generateHumanIdentityDocument(error: Error?,
            self: HumanIdentityDocument?) {
            
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(self, "Human Identity Document is nil.")
            
            expectation.fulfill()
            
            return
        }
        
        HumanIdentityDocument.create(
            humanId: "39885555918766603",
            idDocumentType: 1,
            idDocumentIdentifier: "123456",
            session: provideTestSession(),
            callback: generateHumanIdentityDocument
        )
        
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
        
        self.provideTestHuman(
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
        
        self.provideTestHuman(
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
