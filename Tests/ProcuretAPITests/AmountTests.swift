//
//  AmountTests.swift
//  
//
//  Created by Hugh Jeremy on 21/3/2022.
//

import XCTest
@testable import ProcuretAPI

class AmountTests: XCTestCase {
    
    private static var A: Amount { get { return Amount(
        magnitude: Decimal(420),
        denomination: Currency.AUD
    )}}
    
    private static var B: Amount { get { return Amount(
        magnitude: Decimal(100),
        denomination: Currency.AUD
    )}}
    
    private static var C: Amount { get { return Amount(
        magnitude: Decimal(420),
        denomination: Currency.NZD
    )}}
    
    func testComparability() {
        
        if Self.A != Self.A         { XCTFail("Unexpected !="); return }
        if Self.A == Self.B         { XCTFail("Unexpected =="); return }
        if Self.A < Self.B          { XCTFail("Unexpected <"); return }
        if Self.C > Self.B          { XCTFail("Unexpected >"); return }
        guard Self.A > Self.B else  { XCTFail("Unexpected >"); return }
        guard Self.A == Self.A else { XCTFail("Unexpected !="); return }

    }

    func testAddition() {
        
        let expectation = Amount(
            magnitude: Self.A.magnitude + Self.B.magnitude,
            denomination: Self.A.denomination
        )
        
        let result = Self.A + Self.B
        
        guard result == expectation else {
            XCTFail("Unexpected +: \(result)")
            return
        }
        
    }
    
    func testSubtraction() {
        
        let expectation = Amount(
            magnitude: Self.A.magnitude - Self.B.magnitude,
            denomination: Self.A.denomination
        )
        
        let result = Self.A - Self.B
        
        guard result == expectation else {
            XCTFail("Unexpected -: \(result)")
            return
        }

    }

}
