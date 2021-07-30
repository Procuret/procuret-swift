//
//  Entity.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//

import Foundation

public struct Entity: Codable {
    let publicId: Int
    let publicIdShort: Int
    let entityIdentifiers: Array<EntityIdentifier>
    let legalEntityName: String
    let tradingName: String?
    let phoneNumber: String?
    let businessAddress: String
    let entityType: String?
    let created: String?
    let disposition: Disposition
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case publicIdShort = "public_id_short"
        case entityIdentifiers = "entity_identifiers"
        case legalEntityName = "legal_entity_name"
        case tradingName = "trading_name"
        case phoneNumber = "phone_number"
        case businessAddress = "business_address"
        case entityType = "entity_type"
        case created
        case disposition
    }
    
    public static func setPermissions (
        entityId: Int,
        granteeAgentId: Int,
        read: Bool,
        write: Bool,
        manage: Bool,
        callback: @escaping (Error?, Entity?) -> Void
    ) {
        fatalError("Not implemented")
    }
}
