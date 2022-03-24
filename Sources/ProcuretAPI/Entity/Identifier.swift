//
//  Identifier.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//

import Foundation

public struct EntityIdentifier: Codable {
    
    public static let path = "/"
    
    let idType: EntityIdType
    let idString: String
    
    public enum CodingKeys: String, CodingKey {
        case idType = "id_type"
        case idString = "id"
    }
    
    public static func create(
        entityId: Int,
        idType: Int,
        identifier: String,
        callback: @escaping (Error?, Data?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                entityId: entityId,
                idType: idType,
                identifier: identifier
            ),
            session: nil,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let entityId: Int
        let idType: Int
        let identifier: String
        
        private enum CodingKeys: String, CodingKey {
            case entityId = "entity_id"
            case idType = "id_type"
            case identifier
        }
    }
}
