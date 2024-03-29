//
//  EntityPermission.swift
//  
//
//  Created by Kayla Hoyet on 8/6/21.
//  Modified by Hugh Jeremy 27 Mar 2022
//

import Foundation

public struct EntityPermission: Codable {
    
    internal static let path = "/entity/permission"
    internal static let listPath = EntityPermission.path + "/list"
    
    let entity: EntityHeadline
    let human: HumanHeadline
    let privileges: Array<Privilege>
    let disposition: Disposition
    let created: Date
    
    private enum CodingKeys: String, CodingKey {
        case entity
        case human
        case privileges
        case disposition
        case created
    }
    
    public static func create(
        humanId: String,
        entityId: String,
        privileges: Array<Privilege>,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                humanId: humanId,
                entityId: entityId,
                privileges: privileges
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        entityId: String,
        humanId: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(
                entityId: entityId,
                humanId: humanId
            ),
            session: session,
            query: nil,
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let humanId: String
        let entityId: String
        let privileges: Array<Privilege>
        
        private enum CodingKeys: String, CodingKey {
            case humanId = "human_id"
            case entityId = "entity_id"
            case privileges
        }
    }
    
    private struct RetrieveParameters: Codable {
        let entityId: String
        let humanId: String
        
        private enum CodingKeys: String, CodingKey {
            case entityId = "entity_id"
            case humanId = "human_id"
        }
    }
}
