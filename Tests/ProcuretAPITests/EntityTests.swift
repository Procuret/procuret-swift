//
//  EntityTests.swift
//  
//
//  Created by Hugh Jeremy on 25/3/2022.
//

import XCTest
@testable import ProcuretAPI

class EntityTests: XCTestCase {

    func testRetrieveManyEntities() throws {
        
        let expectation = XCTestExpectation()
        
        Entity.retrieveMany(
            session: Session.forceFromEnvironmentVariables()
        ) { error, entities in
        
            XCTAssertNil(error)
            XCTAssertNotNil(entities)
            XCTAssert(entities?.count ?? 0 > 0)

            expectation.fulfill()
            
            return
    
        }
        
        wait(for: [expectation], timeout: 5)
        
        return

    }

}
