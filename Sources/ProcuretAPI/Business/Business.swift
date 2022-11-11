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
        abn: String,
        address: Address.CreationData,
        session: Session,
        callback: @escaping (Error?, Business?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                abn: abn,
                address: address
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    public static func create(
        entity: Entity,
        session: Session,
        callback: @escaping (Error?, Business?) -> Void
    ) {

        Request.make(
            path: self.path,
            payload: CreateWithEntityPayload(entity_id: entity.publicId),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }

    }
    
    
    private struct CreatePayload: Codable {
        let abn: String
        let address: Address.CreationData
        
        private enum CodingKeys: String, CodingKey {
            case abn
            case address
        }
    }
    
    private struct CreateWithEntityPayload: Codable {
        let entity_id: Int
    }
    
}
