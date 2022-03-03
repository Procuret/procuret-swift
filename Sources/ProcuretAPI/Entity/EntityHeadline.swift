//
//  EntityHeadline.swift
//  
//
//  Created by Kayla Hoyet on 7/23/21.
//

import Foundation

public struct EntityHeadline: Codable {
    
    public let entityId: Int
    public let legalEntityName: String
    
    public enum CodingKeys: String, CodingKey {
        case entityId = "entity_id"
        case legalEntityName = "legal_entity_name"
    }
}
