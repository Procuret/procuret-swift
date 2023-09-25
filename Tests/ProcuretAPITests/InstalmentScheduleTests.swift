//
//  InstalmentSchedule.swift
//  
//
//  Created by Kayla Hoyet on 12/2/22.
//
import XCTest
import PDFKit
@testable import ProcuretAPI

/*
 
 Disabled pending availability of a non-hard-coded Utility.provideTestSeries
 method.
 
 
class InstalmentScheduleTests: XCTestCase {
    
    func testRetrieveInstalmentSchedule() {
        
        let expectation = XCTestExpectation(
            description: "retrieve instalment plan"
        )
        
        func receiveInstalmentScheduleResults(
            error: Error?,
            plan: InstalmentSchedule?
        ) {
                
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(plan, "Instalment Schedule is nil.")
                
            expectation.fulfill()
                
            return
                
        }
        
        Utility.provideTestSeries(
            expectation: expectation
        ) { paymentSeries in
            InstalmentSchedule.retrieve(
                seriesId: paymentSeries.id,
                session: Utility.provideTestSession(),
                endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
                callback: receiveInstalmentScheduleResults
            )
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
    }
    
    func testRetrieveInstalmentSchedulePDF() {
        
        let expectation = XCTestExpectation(
            description: "retrieve instalment plan PDF"
        )
        
        func receiveResult(error: Error?, pdf: PDFDocument?) {
                
            XCTAssertNil(error, "An error occurred.")
            XCTAssertNotNil(pdf, "PDF is nil.")

            expectation.fulfill()
                
            return
                
        }
        
        Utility.provideTestSeries(
            expectation: expectation
        ) { session, paymentSeries in
            InstalmentSchedule.retrievePDF(
                series: paymentSeries,
                session: session,
                endpoint: ApiEndpoint.forceFromEnvironmentVariables(),
                callback: receiveResult
            )
        }
        
        wait(for: [expectation], timeout: 5.0)
        
        return
        
    }

}
*/
