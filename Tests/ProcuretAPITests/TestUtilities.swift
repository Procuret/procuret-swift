//
//  File.swift
//  
//
//  Created by Hugh on 23/9/2022.
//

import XCTest
@testable import ProcuretAPI


internal struct Utility {
    
    static func provideTestSession() -> Session {
        
        do {
            return try Session.fromEnvironmentVariables()
        } catch {
            fatalError("Unable to initalise test session: \(error)")
        }
    }
    
    static func provideTestHumanWithSession(
        expectation: XCTestExpectation,
        callback: @escaping (_ human: Human, _ session: Session) -> Void,
        perspective: Perspective = .business
    ) {
        
        Self.provideTestHuman(
            expectation: expectation
        ) { human, secret, code in
            Session.create(
                secret: secret,
                email: human.emailAddress.rawEmailString,
                code: code,
                perspective: perspective
            ) { error, session in

                guard let session = session else {
                    XCTFail("Unable to generate test Session")
                    expectation.fulfill()
                    return
                }
                
                callback(human, session)
                
                return

            }
        }
        
    }
    
    static func provideTestHuman(
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
        let email = TestEmail.generateEmail()
        
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

    
}
