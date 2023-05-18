//
//  EntityIdentifier.swift
//  
//
//  Created by Hugh on 20/4/2023.
//

import Foundation


public enum EntityIdentifierType: Int, Codable, CaseIterable, Identifiable,
                                  Equatable {
    
    case australianBusinessNumber = 1
    case australianCompanyNumber = 2
    case newZealandBusinessNumber = 3
    
    public var name: String { get {
        switch self {
        case .australianBusinessNumber:
            return "Australian Business Number"
        case .australianCompanyNumber:
            return "Australian Company Number"
        case .newZealandBusinessNumber:
            return "New Zealand Business Number"
        }
    } }
    
    public var abbreviation: String { get {
        switch self {
        case .australianBusinessNumber:
            return "ABN"
        case .australianCompanyNumber:
            return "ACN"
        case .newZealandBusinessNumber:
            return "NZBN"
        }
    } }
    
    public var requiredLength: Int { get {
        
        switch self {
        case .australianBusinessNumber:
            return 11
        case .australianCompanyNumber:
            return 9
        case .newZealandBusinessNumber:
            return 13
        }
        
    } }
    
    public var country: Country { get {
        
        switch self {
        case .australianBusinessNumber, .australianCompanyNumber:
            return .australia
        case .newZealandBusinessNumber:
            return .newZealand
        }

    } }

    public var id: Int { get { return self.rawValue } }

}

public struct EntityIdentifier: Codable, Identifiable {
    
    public let identifier: String
    public let identifierType: EntityIdentifierType
    
    public var id: String { get { return
        self.identifierType.abbreviation + " " + self.identifier
    } }

    private enum CodingKeys: String, CodingKey {
        
        case identifier
        case identifierType = "identifier_type"
        
    }
    
    public init(identifier: String, identifierType: EntityIdentifierType) {
        self.identifier = identifier
        self.identifierType = identifierType
        return
    }

}
