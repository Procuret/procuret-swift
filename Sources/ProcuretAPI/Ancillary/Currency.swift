//
//  Currency.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct Currency: Codable, Identifiable, Hashable, CaseIterable,
                        Sendable {
    
    public let indexid: Int
    public let name: String
    public let iso4217: String
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
        iso4217: "AUD",
        exponent: 2,
        symbol: "$"
    )}}
    
    public static var NZD: Self { get { return Currency(
        indexid: 2,
        name: "New Zealand Dollar",
        iso4217: "NZD",
        exponent: 2,
        symbol: "$"
    )}}
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.indexid)
        return
    }
    
    private enum CodingKeys: String, CodingKey {
        case indexid
        case name
        case iso4217 = "iso_4217"
        case exponent
        case symbol
    }
    
    public static func with(indexid: Int) -> Self? {
        for currency in Self.allCases {
            if currency.indexid == indexid { return currency }
        }
        
        return nil
    }
    
    public static func associatedWith(country: Country) -> Self? {
        switch country {
        case .australia:
            return .AUD
        case .newZealand:
            return .NZD
        default:
            return nil
        }
    }

}
