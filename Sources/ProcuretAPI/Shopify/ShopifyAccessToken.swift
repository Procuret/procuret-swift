//
//  ShopifyAccessToken.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct ShopifyAccessToken: Codable {
    
    internal static let path = "/shopify/access-token"
    
    let publicId: String
    let created: ProcuretTime
    let creatingAgentId: String
    let accessToken: String
    let shopName: String
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case created
        case creatingAgentId
        case accessToken = "access_token"
        case shopName = "shop_name"
    }
    
    public static func create(
        url: String,
        requestId: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(url: url, requestId: requestId),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let url: String
        let requestId: String
        
        private enum CodingKeys: String, CodingKey {
            case url
            case requestId = "request_id"
        }
    }
}
