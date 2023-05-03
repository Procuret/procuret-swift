//
//  InstalmentLinkTests.swift
//  
//
//  Created by Hugh on 3/5/2023.
//

import XCTest
@testable import ProcuretAPI


final class InstalmentLinkTests: XCTestCase {

    func testCreateInstalmentLink() {
        
        let expectation = XCTestExpectation(
            description: "Create Instalment Link"
        )
        
        Utility.provideTestSupplier(
            expectation: expectation
        ) { supplier, session in
            
            InstalmentLink.create(
                authenticatedBy: session,
                supplier: supplier,
                amount: Amount(
                    magnitude: Decimal(string: "420")!,
                    denomination: .AUD
                ),
                identifier: "PSL TEST 001",
                inviteeEmail: "hugh@procuret-test-domain.org",
                communicate: false,
                at: .forceFromEnvironmentVariables()
            ) { error, link in
                
                XCTAssertNil(error)
                XCTAssertNotNil(link)
                
                expectation.fulfill()
                
                return

            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    func testListInstalmentLinks() {
        
        let expectation = XCTestExpectation(
            description: "List Instalment Links"
        )
        
        Utility.provideTestSupplier(
            expectation: expectation
        ) { supplier, session in
            
            InstalmentLink.create(
                authenticatedBy: session,
                supplier: supplier,
                amount: Amount(
                    magnitude: Decimal(string: "420")!,
                    denomination: .AUD
                ),
                identifier: "PSL TEST 001",
                inviteeEmail: "hugh@procuret-test-domain.org",
                communicate: false,
                at: .forceFromEnvironmentVariables()
            ) { error, link in
                
                XCTAssertNil(error)
                XCTAssertNotNil(link)
                
                guard link != nil else { expectation.fulfill(); return }
                
                InstalmentLink.retrieveMany(
                    authenticatedBy: session,
                    supplier: supplier,
                    at: .forceFromEnvironmentVariables()
                ) { error, links in
                    
                    XCTAssertNil(error)
                    XCTAssertNotNil(links)
                    XCTAssert(links?.count ?? 0 > 0)
                    
                    expectation.fulfill()
                    
                    return
        
                }
                
                return

            }
            
            return
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return

    }


}
