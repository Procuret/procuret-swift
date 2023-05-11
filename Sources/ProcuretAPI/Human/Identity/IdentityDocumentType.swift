//
//  IdentityDocumentType.swift
//  
//
//  Created by Kayla Hoyet on 10/28/21.
//

import Foundation

public enum IdentityDocumentType: Int, Codable, Identifiable {

    case australianDriversLicense = 1
    case newZealandDriversLicense = 2
    
    public var id: Int { get { return self.rawValue } }

    public var name: String { get {
        switch self {
        case .australianDriversLicense:
            return "Australian Drivers License"
        case .newZealandDriversLicense:
            return "New Zealand Drivers License"
        }
    } }
    
    public var associatedCountry: Country { get {
        switch self {
        case .australianDriversLicense:
            return Country.australia
        case .newZealandDriversLicense:
            return Country.newZealand
        }
    } }
    
    public static func associatedWith(country: Country) -> Self? {
        switch country {
        case Country.australia:
            return .australianDriversLicense
        case Country.newZealand:
            return .newZealandDriversLicense
        default:
            return nil
        }
    }
    
}
