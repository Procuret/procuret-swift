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
            session: Session.forceFromEnvironmentVariables(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables()
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
    
    func testCreateEntity() {
        
        let expectation = XCTestExpectation(
            description: "create Entity"
        )
        
        func receiveCreateEntityResult(error: Error?, entity: Entity?) {
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(entity, "Entity is nil.")
            
            expectation.fulfill()
            return
        }
        
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
            legalEntityName: "PROCURET OPERATING PTY LIMITED",
            session: Utility.provideTestSession(),
            endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
            callback: receiveCreateEntityResult
        )
        
        wait(for: [expectation], timeout: 5.0)
        return
    }
    
    func testRetrieveEntity() {
        
        let expectation = XCTestExpectation(description: "Retrieve Entity")
        
        Utility.provideTestEntity(
            expectation: expectation
        ) { createdEntity, session in
            
            Entity.retrieve(
                authenticatedBy: session,
                withPublicId: createdEntity.publicId,
                at: .forceFromEnvironmentVariables()
            ) { error, entity in
                
                XCTAssertNil(error)
                XCTAssertNotNil(entity)
                XCTAssertTrue(entity?.publicId ?? -1 == createdEntity.publicId)
                
                expectation.fulfill()
                
                return

            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }
    
}
