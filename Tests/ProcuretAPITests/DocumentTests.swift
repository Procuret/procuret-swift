//
//  File.swift
//  
//
//  Created by Hugh on 20/4/2022.
//
import XCTest
@testable import ProcuretAPI


class DocumentTests: XCTestCase {

    func testStripeDDRRetrieval() {
        
        let expectation = XCTestExpectation()
        
        StripeDDRAgreement.retrieveLatest { error, agreement in
            XCTAssertNil(error)
            XCTAssertNotNil(agreement)
            expectation.fulfill()
            return
        }
        
        wait(for: [expectation], timeout: 3.0)
        
        return
        
    }
    
    func testTOSRetrieval() {
        
        let expectation = XCTestExpectation()
        
        TOS.retrieveLatest { error, agreement in
            XCTAssertNil(error)
            XCTAssertNotNil(agreement)
            expectation.fulfill()
            return
        }
        
        wait(for: [expectation], timeout: 3.0)
        return
        
    }
    
    func testPrivacyPolicyRetrieval() {
        
        let expectation = XCTestExpectation()
        
        PrivacyPolicy.retrieveLatest { error, agreement in
            XCTAssertNil(error)
            XCTAssertNotNil(agreement)
            expectation.fulfill()
            return
        }
        
        wait(for: [expectation], timeout: 3.0)
        return
        
    }

}
