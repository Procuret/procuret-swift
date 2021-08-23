//
//  XeroOrganisation.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct XeroOrganisation: Codable {
    
    internal static let path = "/xero/organisation"
    
    let entityId: String
    let shortCode: String
    
    private enum CodingKeys: String, CodingKey {
        case entityId = "entity_id"
        case shortCode = "shortcode"
    }
    
    public static func create(
        entityId: String,
        session: Session?,
        callback: @escaping (Error?, XeroOrganisation?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(entityId: entityId),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
                fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        entityId: String,
        session: Session?,
        callback: @escaping (Error?, XeroOrganisation?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(entityId: entityId),
            session: session,
            query: nil,
            method: .GET
        ) { error, data in
            fatalError("Not implemented")
        }
    }
                
    private struct CreatePayload: Codable {
        let entityId: String
        
        private enum CodingKeys: String, CodingKey {
            case entityId = "entity_id"

        }
    }
    
    private struct RetrieveParameters: Codable {
        let entityId: String
        
        private enum CodingKeys: String, CodingKey {
            case entityId = "entity_id"
        }
    }
}
