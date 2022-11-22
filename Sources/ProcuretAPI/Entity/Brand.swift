//
//  Brand.swift
//  
//
//  Created by Kayla Hoyet on 7/23/21.
//

import Foundation

public struct Brand: Codable {
    
    internal static let path = "/entity/brand"
    
    let entityId: Int
    let name: String
    let saleMessage: String
    let created: String

    
    public enum CodingKeys: String, CodingKey {
        case entityId = "entity_id"
        case name
        case saleMessage = "sale_message"
        case created
    }
    
    public static func create(
        name: String,
        media: Array<BrandMedia>,
        saleMessage: String,
        entityId: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Brand?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                name: name,
                media: media,
                saleMessage: saleMessage,
                entityId: entityId
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
        
    private struct CreatePayload: Codable {
        let name: String
        let media: Array<BrandMedia>
        let saleMessage: String
        let entityId: String
        
            
        private enum CodingKeys: String, CodingKey {
            case name = "brand_name"
            case media
            case saleMessage = "sale_message"
            case entityId = "entity_id"
        }
    }
}

