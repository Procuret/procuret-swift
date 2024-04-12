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
            _ business: Business,
            _ owner: Human
        ) {
            
            guard let placeboData = "placebo".data(using: .utf8) else {
                XCTFail(); expectation.fulfill(); return
            }
            
            UnknownSupplierFinanceRequest.create(
                authenticatedBy: session,
                applicantHuman: owner,
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
                invoiceBodyBase64Encoded: ExamplePDF.data,
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
        
        Utility.provideTestBusinessWithOwner(
            expectation: expectation
        ) { business, session, owner in
            
            createUSFR(session, business, owner)
 
            return
            
        }
        
        self.wait(for: [expectation], timeout: 5.0)
        
        return

    }
    
}
