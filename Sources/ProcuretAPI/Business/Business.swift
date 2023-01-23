//
//  Business.swift
//  
//
//  Created by Kayla Hoyet on 10/28/21.
//

import Foundation

public struct Business: Codable {
    
    internal static let path = "/business"
    
    public let entity: Entity
    
    private enum CodingKeys: String, CodingKey {
        case entity
    }
    
    public static func create(
        identifier: String,
        idType: EntityIdType,
        address: Address.CreationData,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Business?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                identifier: identifier,
                idType: idType,
                address: address
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    public static func create(
        entity: Entity,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Business?) -> Void
    ) {

        Request.make(
            path: self.path,
            payload: CreateWithEntityPayload(entity_id: entity.publicId),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }

    }
    
    
    private struct CreatePayload: Codable {
        let identifier: String
        let idType: EntityIdType
        let address: Address.CreationData
        
        private enum CodingKeys: String, CodingKey {
            case identifier
            case idType = "identifier_type"
            case address
        }
    }
    
    private struct CreateWithEntityPayload: Codable {
        let entity_id: Int
    }
    
}
