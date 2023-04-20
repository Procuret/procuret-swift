//
//  EntityIdentifier.swift
//  
//
//  Created by Hugh on 20/4/2023.
//

import Foundation


public enum EntityIdentifierType: Int, Codable {
    
    case australianBusinessNumber = 1
    case australianCompanyNumber = 2
    case newZealandBusinessNumber = 3

}

public struct EntityIdentifier: Codable {
    
    let identifier: String
    let identifierType: EntityIdentifierType
    
    private enum CodingKeys: String, CodingKey {
        
        case identifier
        case identifierType = "identifier_type"
        
    }

}
