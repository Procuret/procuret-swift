//
//  BasicTests.swift
//  
//
//  Created by Hugh Jeremy on 7/9/21.
//
import XCTest
@testable import ProcuretAPI

final class BasicTests: XCTestCase {
    
    func testLoadSessionFromEnvironment() {
        
        do {
            let session = try Session.fromEnvironmentVariables()
            XCTAssertNotNil(session)
        } catch {
            XCTFail("Experienced error: \(error)")
        }
        
        return
        
    }

}
