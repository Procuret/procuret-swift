//
//  Amount.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct Amount: Codable {
    
    private static var prettyFormatter: NumberFormatter {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }
    }
    
    private static var decodeFormatter: NumberFormatter {
        get {
            let formatter = NumberFormatter()
            formatter.generatesDecimalNumbers = true
            formatter.numberStyle = .decimal
            return formatter
        }
    }
    
    public let magnitude: Decimal
    public let denomination: Currency
    
    public enum CodingKeys: String, CodingKey {
        case magnitude
        case denomination
    }
    
    public init(
        magnitude: Decimal,
        denomination: Currency
    ) {
        
        self.magnitude = magnitude
        self.denomination = denomination
        
        return

    }
    
    public init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.denomination = try values.decode(
            Currency.self,
            forKey: .denomination
        )
        
        let rawMagnitude = try values.decode(String.self, forKey: .magnitude)
        guard let decimalMagnitude = (
            Self.decodeFormatter.number(from: rawMagnitude) as? Decimal
        ) else {
            throw ProcuretAPIError(
                .jsonParseFailed,
                message: "Failed to decode \(rawMagnitude) to Decimal"
            )
        }
        
        self.magnitude = decimalMagnitude
        
        return
    
    }
    
    public func asDecimalString(showFractionalUnits: Bool = true) -> String {
        if showFractionalUnits {
            let digits = self.magnitude.exponent
            Self.prettyFormatter.minimumFractionDigits = digits
            Self.prettyFormatter.maximumFractionDigits = digits
        } else {
            Self.prettyFormatter.minimumFractionDigits = 0
            Self.prettyFormatter.maximumFractionDigits = 0
        }
        return Self.prettyFormatter.string(
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
