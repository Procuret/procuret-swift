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
        perspective: Perspective = .business,
        callback: @escaping (_ human: Human, _ session: Session) -> Void
    ) {
        
        Self.provideTestHuman(
            expectation: expectation
        ) { human, secret, code in
            Session.create(
                secret: secret,
                email: human.emailAddress.rawEmailString,
                code: code,
                perspective: perspective,
                endpoint: ApiEndpoint.forceFromEnvironmentVariables()
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
        
        let session: SessionRepresentative?
        
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
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
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
    
    
    static func provideTestEntity(
        expectation: XCTestExpectation,
        callback: @escaping (Entity) -> Void
    ) -> Void {
        
        return Self.provideTestEntity(
            expectation: expectation
        ) { entity, _ in callback(entity)}

    }
    
    static func provideTestEntity(
        expectation: XCTestExpectation,
        callback: @escaping (Entity, Session) -> Void
    ) -> Void {
        
        let session = Utility.provideTestSession()
        
        Entity.create(
            identifier: EntityIdentifier(
                identifier: "77630036789",
                identifierType: .australianBusinessNumber
            ),
            address: Address.CreationData(
                line1: "44 Bridge Street",
                line2: nil,
                line3: nil,
                line4: nil,
                postalCode: "2000",
                locality: "NSW",
                regionId: 1,
                countryId: 1
            ),
            session: Utility.provideTestSession(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: { error, entity in
                
                XCTAssertNil(error)
                XCTAssertNotNil(entity)
                
                guard let entity = entity else {
                    expectation.fulfill()
                    return
                }
                
                callback(entity, session)
                
                return

            }
        )
        
        return

    }
    
    static func provideTestBankAccount(
        expectation: XCTestExpectation,
        callback: @escaping (BankAccount) -> Void
    ) -> Void {
        BankAccount.create(
            bsbCode: "000000",
            accountNumber: "000123456",
            accountName: "SwiftTest BankAccount",
            entityId: "13991055489669749",
            authorityId: nil,
            session: Utility.provideTestSession(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: { error, bankAccount in
                
                XCTAssertNil(error)
                XCTAssertNotNil(bankAccount)
                
                guard let bankAccount = bankAccount else {
                    expectation.fulfill()
                    return
                }
                
                callback(bankAccount)
                return
                
            }
        )
        
        return
    }
    
    static func provideTestBusiness(
        expectation: XCTestExpectation,
        callback: @escaping (Business) -> Void
    ) -> Void {
        
        Business.create(
            identifier: EntityIdentifier(
                identifier: "77630036789",
                identifierType: .australianBusinessNumber
            ),
            address: Address.CreationData(
                line1: "47 Brighton Rd",
                line2: nil,
                line3: nil,
                line4: nil,
                postalCode: "4101",
                locality: "QLD",
                regionId: 1,
                countryId: 1
            ),
            session: Utility.provideTestSession(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: { error, business in
                
                XCTAssertNil(error)
                XCTAssertNotNil(business)
                
                guard let business = business else {
                    expectation.fulfill()
                    return
                }
                
                callback(business)
                return
            }
        )
        
        return
    }
    
    static func provideTestSeries(
        expectation: XCTestExpectation,
        callback: @escaping (PaymentSeries) -> Void
    ) -> Void {

        Self.provideTestSeries(
            expectation: expectation
        ) { _, series in
            callback(series)
        }
        
        return

    }
    
    static func provideTestSeries(
        expectation: XCTestExpectation,
        callback: @escaping (SessionRepresentative, PaymentSeries) -> Void
    ) -> Void {
        
        let session = Utility.provideTestSession()

        PaymentSeries.retrieve(
            session: session,
            publicId: "uiK3ihKJvYtw",
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: { error, paymentSeries in

                XCTAssertNil(error)
                XCTAssertNotNil(paymentSeries)
                
                guard let paymentSeries = paymentSeries else {
                    expectation.fulfill()
                    return
                }
                
                callback(session, paymentSeries)
                return
            }
        )
        
        return

    }
    
    static func provideTestSupplierFromEntity(
        expectation: XCTestExpectation,
        callback: @escaping (Supplier) -> Void
    ) -> Void {
        
        fatalError(".createFromEntity not implemented")
        
        /*
        Supplier.createFromEntity(
            entityId: "13991055489669749",
            session: Utility.provideTestSession(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: { error, supplier in
                XCTAssertNil(error)
                XCTAssertNotNil(supplier)
                
                guard let supplier = supplier else {
                    expectation.fulfill()
                    return
                }
                callback(supplier)
                return
            }
        )
        
        return
         
         */
    }
    
    static func provideTestSupplier(
        expectation: XCTestExpectation,
        callback: @escaping (Supplier) -> Void
    ) -> Void {
        Supplier.create(
            legalName: "Test Supplier",
            tradingName: nil,
            phoneNumber: "+61400010001",
            address: Address.CreationData(
                line1: "44 Bridge Street",
                line2: nil,
                line3: nil,
                line4: nil,
                postalCode: "2000",
                locality: "NSW",
                regionId: 1,
                countryId: 1
            ),
            session: Utility.provideTestSession(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: { error, supplier in
                
                XCTAssertNil(error)
                XCTAssertNotNil(supplier)
                
                guard let supplier = supplier else {
                    expectation.fulfill()
                    return
                }
                
                callback(supplier)
                return
                
            }
        )
    }
}
