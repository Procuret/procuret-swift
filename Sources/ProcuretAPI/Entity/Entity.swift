//
//  Entity.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//

import Foundation

public struct Entity: Codable, Identifiable, Hashable {
    
    internal static let path = "/entity/permissions"
    internal static let listPath = "/entity/list"
    
    public let publicId: Int
    public let publicIdShort: String
    public let entityIdentifiers: Array<EntityIdentifier>
    public let legalEntityName: String
    public let tradingName: String?
    public let phoneNumber: String?
    public let entityType: EntityType?
    public let created: Date?
    public let disposition: Disposition
    
    public var id: Int { get { return self.publicId } }
    
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
    
    public enum OrderBy: String {
        case name = "name"
        case created = "created"
        case modified = "modified"
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
    
    public func hash(into hasher: inout Hasher) -> Void {
        hasher.combine(self.publicId)
        return
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.publicId == rhs.publicId
    }
    
    public static func retrieveMany(
        session: Session,
        accessibleTo: Agent? = nil,
        nameFragment: String? = nil,
        limit: Int = 20,
        offset: Int = 0,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = Self.OrderBy.created,
        callback: @escaping (Error?, Array<Self>?) -> Void
    ) -> Void {
        
        Request.make(
            path: Self.listPath,
            data: nil,
            session: session,
            query: QueryString(targetsOnly: [].compactMap{ $0 }),
            method: .GET
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
            return
        }
        
        return

    }

}
