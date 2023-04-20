//
//  File.swift
//  
//
//  Created by Hugh on 20/4/2023.
//

import XCTest
@testable import ProcuretAPI

class UnknownSupplierFinanceRequestTests: XCTestCase {
 
    func testCreateUnknownSupplierFinanceRequest() {
        
        let expectation = XCTestExpectation(description: "Create USFR")
        
        func createUSFR(
            _ session: SessionRepresentative,
            _ business: Business
        ) {
            
            guard let placeboData = "placebo".data(using: .utf8) else {
                XCTFail(); expectation.fulfill(); return
            }
            
            UnknownSupplierFinanceRequest.create(
                authenticatedBy: session,
                forCustomer: business,
                supplierIdentifier: EntityIdentifier(
                    identifier: "77630036789",
                    identifierType: .australianBusinessNumber
                ),
                invoiceIdentifier: "KX - 001",
                invoiceAmount: Amount(
                    magnitude: 420,
                    denomination: .AUD
                ),
                invoiceBody: placeboData,
                at: ApiEndpoint.forceFromEnvironmentVariables()
            ) { error in

                guard error == nil else {
                    XCTFail(error?.localizedDescription ?? "No error")
                    expectation.fulfill(); return
                }
                
                expectation.fulfill()
                return

            }
        }
        
        Utility.provideTestEntity(expectation: expectation) { e, s in
            Business.create(
                entity: e,
                session: s,
                endpoint: .forceFromEnvironmentVariables()
            ) { e, b in
                guard let b = b else {
                    XCTFail(e?.localizedDescription ?? "No error")
                    expectation.fulfill()
                    return
                }
                createUSFR(s, b)
                return
            }
            return
        }
        
        self.wait(for: [expectation])
        
        return

    }
    
}
