//
//  EntityPermission.swift
//  
//
//  Created by Kayla Hoyet on 8/6/21.
//

import Foundation

public struct EntityPermission: Codable {
    
    internal static let path = "/entity/permission"
    
    let entity: EntityHeadline
    let human: HumanHeadline
    let privileges: Array<Privilege>
    let disposition: Disposition
    let created: ProcuretTime
    
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
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(humanId: humanId, entityId: entityId,
                privileges: privileges),
            session: session,
            query: nil,
            method: .POST
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
}
