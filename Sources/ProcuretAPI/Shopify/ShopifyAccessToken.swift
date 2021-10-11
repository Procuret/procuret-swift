//
//  ShopifyAccessToken.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct ShopifyAccessToken: Codable {
    
    internal static let path = "/shopify/access-token"
    internal static let listPath = ShopifyAccessToken.path + "/list"
    
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
            payload: CreatePayload(
                url: url,
                requestId: requestId
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    public static func retrieveList(
        supplierId: String,
        active: Bool?,
        session: Session?,
        callback: @escaping (Error?, Array<Self>?) -> Void
    ) {
        Request.make(
            path: self.listPath,
            payload: RetrieveParameters(
                supplierId: supplierId,
                active: active
            ),
            session: session,
            query: nil,
            method: .GET
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
    
    private struct RetrieveParameters: Codable {
        let supplierId: String
        let active: Bool?
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case active
        }
    }
}
