//
//  Identifier.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//

import Foundation

public struct EntityIdentifierRecord: Codable, Identifiable, Equatable,
                                        Hashable, Sendable {
    
    public static let path = "/"
    
    public let idType: EntityIdentifierType
    public let idString: String
    
    public var id: String { get { return self.idString } }
    
    public var asIdentifier: EntityIdentifier { get {
        return EntityIdentifier(
            identifier: self.idString,
            identifierType: EntityIdentifierType(rawValue: self.idType.id)!
        )
    } }
    
    public enum CodingKeys: String, CodingKey {
        case idType = "id_type"
        case idString = "id"
    }
    
    public static func create(
        entityId: Int,
        idType: Int,
        identifier: String,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, Data?) -> Void
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
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable, Sendable {
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
