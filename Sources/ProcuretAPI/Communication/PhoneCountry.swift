//
//  PhoneCountry.swift
//  
//
//  Created by Hugh on 19/7/2022.
//

import Foundation

public enum PhoneCountryCode: String, Identifiable, Hashable, CaseIterable,
                              Sendable{
    
    case Australia = "+61"
    case NewZealand = "+64"
    case UnitedStates = "+1"
    case Singapore = "+65"
    case Other = "Other"
    
    public var prefix: String { get {
        if self == .Other { return "" }
        return self.rawValue
    } }

    public var id: String { get { return self.rawValue } }

    public var flagEmoji: String { get {
        
        switch self {
        case .Australia:
            return "🇦🇺"
        case .NewZealand:
            return "🇳🇿"
        case .UnitedStates:
            return "🇺🇸"
        case .Singapore:
            return "🇸🇬"
        case .Other:
            return "🌏"
        }
        
    } }
    
    public var nameAndFlag: String { get {
      
        return "\(self.flagEmoji) \(self.rawValue)"

    } }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    public static func minimumNumberLength(
        _ code: Self,
        requireSms: Bool = false
    ) -> Int {
        
        if !requireSms { return 7 }
        
        switch code {
        case .Australia: return 9
        case .NewZealand: return 8
        case .UnitedStates: return 9
        case .Singapore: return 8
        case .Other: return 6
        }
        
    }
    
    public func minimumNumberLength(requireSms: Bool = false) -> Int {
        
        return Self.minimumNumberLength(self, requireSms: requireSms)
    
    }
    
    public static func numberAppearsSmsCapable(
        code: Self,
        digitsSansCode: String
    ) -> Bool {
        
        guard let mayBeginWith = code.smsNumbersMayBeginWith else {
            return true
        }
        
        for prefix in mayBeginWith {
            if digitsSansCode.starts(with: prefix) { return true }
        }
        
        return false

    }

    public func numberAppearsSmsCapable(
        digitsSansCode: String
    ) -> Bool {
        
        return Self.numberAppearsSmsCapable(
            code: self,
            digitsSansCode: digitsSansCode
        )

    }

    public var smsNumbersMayBeginWith: Array<String>? {
        
        switch self {
        case .Australia: return ["04", "05"]
        case .NewZealand: return ["02"]
        case .Singapore: return ["8", "9"]
        case .UnitedStates: return nil
        case .Other: return nil
        }

    }

}
