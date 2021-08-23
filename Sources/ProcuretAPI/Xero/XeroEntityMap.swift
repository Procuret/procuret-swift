//
//  XeroEntityMap.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct XeroEntityMap: Codable {
    
    internal static let path = "/xero/entity-map"
    
    public static func create(
        entityId: String,
        tenantId: String,
        session: Session?,
        callback: @escaping (Error?, XeroEntityMap?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(entityId: entityId, tenantId: tenantId),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let entityId: String
        let tenantId: String
        
        private enum CodingKeys: String, CodingKey {
            case entityId = "entity_id"
            case tenantId = "tenant_id"
        }
    }
}
