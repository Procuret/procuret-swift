//
//  Currency.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct Currency: Codable, Identifiable, Hashable, CaseIterable {
    
    public let indexid: Int
    public let name: String
    public let iso_4217: String
    public let exponent: Int
    public let symbol: String
    
    public var id: Int { get { return self.indexid } }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.indexid == rhs.indexid
    }
    
    public static func != (lhs: Self, rhs: Self) -> Bool {
        return lhs.indexid != rhs.indexid
    }
    
    public static let allCases: Array<Currency> = [.AUD, .NZD]

    public static var AUD: Self { get { return Currency(
        indexid: 1,
        name: "Australian Dollar",
        iso_4217: "AUD",
        exponent: 2,
        symbol: "$"
    )}}
    
    public static var NZD: Self { get { return Currency(
        indexid: 2,
        name: "New Zealand Dollar",
        iso_4217: "NZD",
        exponent: 2,
        symbol: "$"
    )}}
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.indexid)
        return
    }

}
