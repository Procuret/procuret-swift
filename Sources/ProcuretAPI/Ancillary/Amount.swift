//
//  Amount.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct Amount: Codable {
    
    public let rawMagnitude: String
    public let denomination: Currency
    
    public var magnitude: Decimal { get {
        return Decimal(string: self.rawMagnitude) ?? -1
    } }
    
    public enum CodingKeys: String, CodingKey {
        case magnitude
        case denomination
    }
    
    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.rawMagnitude, forKey: .magnitude)
        try container.encode(denomination.id, forKey: .denomination)
        return
    }
    
    public init(
        magnitude: Decimal,
        denomination: Currency
    ) {
        
        self.rawMagnitude = String(describing: magnitude)
        self.denomination = denomination
        
        return

    }
    
    public init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.denomination = try values.decode(
            Currency.self,
            forKey: .denomination
        )
        self.rawMagnitude = try values.decode(String.self, forKey: .magnitude)

        return
            
    }
    
    public func asDecimalString(showFractionalUnits: Bool = true) -> String {
        
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = .decimal
        
        if showFractionalUnits {
            let digits = self.denomination.exponent
            formatter.minimumFractionDigits = digits
            formatter.maximumFractionDigits = digits
        } else {
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
        }
        return formatter.string(
            from: self.magnitude as NSDecimalNumber
        ) ?? "FORMAT_FAILED"

    }
    
    public func asSymbolisedDecimalString(
        showFractionalUnits: Bool = true
    ) -> String {
        
        let symbol = self.denomination.symbol
        return symbol + " " + self.asDecimalString(
            showFractionalUnits: showFractionalUnits
        )
    }
    
    public func asDenominatedDecimalString(
        showFractionalUnits: Bool = true
    ) -> String {
        return self.denomination.iso4217 + " " + self.asDecimalString(
            showFractionalUnits: showFractionalUnits
        )
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.denomination != rhs.denomination { return false }
        if lhs.magnitude != rhs.magnitude { return false }
        return true
    }
    
    public static func areComparable(_ lhs: Self, _ rhs: Self) -> Bool {
        if lhs.denomination != rhs.denomination { return false }
        return true
    }
    
    public static func != (lhs: Self, rhs: Self) -> Bool {
        return !(lhs == rhs)
    }
                    
    public static func + (lhs: Self, rhs: Self) -> Self {
        if !Self.areComparable(lhs, rhs) { return Self.badArithmeticZero }
        return Amount(
            magnitude: lhs.magnitude + rhs.magnitude,
            denomination: lhs.denomination
        )
    }
    
    public static func - (lhs: Self, rhs: Self) -> Self {
        if !Self.areComparable(lhs, rhs) { return Self.badArithmeticZero }
        return Amount(
            magnitude: lhs.magnitude - rhs.magnitude,
            denomination: lhs.denomination
        )
    }
    
    public static func / (lhs: Self, rhs: Self) -> Self {
        if (!Self.areComparable(lhs, rhs)) { return Self.badArithmeticZero }
        return Amount(
            magnitude: lhs.magnitude / rhs.magnitude,
            denomination: lhs.denomination
        )
    }
    
    static public func * (lhs: Self, rhs: Self) -> Self {
        if (!Self.areComparable(lhs, rhs)) { return Self.badArithmeticZero }
        return Amount(
            magnitude: lhs.magnitude * rhs.magnitude,
            denomination: lhs.denomination
        )
    }
    
    static public func * (lhs: Self, rhs: Int) -> Self {
        return Amount(
            magnitude: lhs.magnitude * Decimal(rhs),
            denomination: lhs.denomination
        )
    }
    
    static public func * (lhs: Self, rhs: Decimal) -> Self {
        return Amount(
            magnitude: lhs.magnitude * rhs,
            denomination: lhs.denomination
        )
    }
    
    static public func * (lhs: Self, rhs: Double) -> Self {
        return Amount(
            magnitude: lhs.magnitude * Decimal(rhs),
            denomination: lhs.denomination
        )
    }
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        if (!Self.areComparable(lhs, rhs)) { return false }
        return lhs.magnitude < rhs.magnitude
    }

    public static func > (lhs: Self, rhs: Self) -> Bool {
        if (!Self.areComparable(lhs, rhs)) { return false }
        return lhs.magnitude > rhs.magnitude
    }
    
    private static var badArithmeticZero: Self {
        return Self(
            magnitude: 0,
            denomination: Currency.AUD
        )
    }
}
