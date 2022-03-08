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
    
    func testOptionallyLoadSessionFromEnvironment() {
        
        do {
            //let _ = try Session.fromEnvironmentVariables()
            let nilSession = try Session.optionallyFromEnvironmentVariables(
                keyVariableName: "GARBAGE_NAME"
            )
            guard nilSession == nil else {
                XCTFail("Session unexpectedly not nil")
                return
            }
        } catch {
            XCTFail("Experienced error: \(error)")
        }
        
        return
        
    }

}
