//
//  PhoneCountry.swift
//  
//
//  Created by Hugh on 19/7/2022.
//

import Foundation

public enum PhoneCountryCode: String, Identifiable, Hashable {
    
    case Australia = "+61"
    case NewZealand = "+64"
    case UnitedStates = "+1"
    case Singapore = "+65"
    case Other = ""
    
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
    
    public var codeAndFlag: String { get {
      
        return "\(self.flagEmoji) \(self.rawValue)"

    } }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

}
