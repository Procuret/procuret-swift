//
//  Entity.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//

import Foundation

public struct Entity: Codable {
    
    internal static let path = "/entity/permissions"
    internal static let listPath = "/entity/list"
    
    public let publicId: Int
    public let publicIdShort: String
    public let entityIdentifiers: Array<EntityIdentifier>
    public let legalEntityName: String
    public let tradingName: String?
    public let phoneNumber: String?
    public let entityType: String?
    public let created: String?
    public let disposition: Disposition
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case publicIdShort = "public_id_short"
        case entityIdentifiers = "entity_identifiers"
        case legalEntityName = "legal_entity_name"
        case tradingName = "trading_name"
        case phoneNumber = "phone_number"
        case entityType = "entity_type_name"
        case created
        case disposition
    }
    
    public static func setPermissions(
        entityId: Int,
        granteeAgentId: Int,
        read: Bool,
        write: Bool,
        manage: Bool,
        callback: @escaping (Error?, Entity?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: SetPermissions(
                entityId: entityId,
                granteeAgentId: granteeAgentId,
                read: read,
                write: write,
                manage: manage
            ),
            session: nil,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
        
    private struct SetPermissions: Codable {
        let entityId: Int
        let granteeAgentId: Int
        let read: Bool
        let write: Bool
        let manage: Bool
        
        private enum CodingKeys: String, CodingKey {
            case entityId = "entity_id"
            case granteeAgentId = "agent_id"
            case read
            case write
            case manage
        }
    }
}
