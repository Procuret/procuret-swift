//
//  ShopifyCustomApp.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//  Modified by Hugh Jeremy 27 Mar 2022
//

import Foundation

public struct ShopifyCustomApp: Codable {
    
    internal static let path = "/shopify/custom-app"
    internal static let listPath = ShopifyCustomApp.path + "/list"
    
    let supplierId: String
    let apiKey: String
    let apiSecretKey: String
    let shopName: String
    let disposition: Disposition
    let created: Date
    
    private enum CodingKeys: String, CodingKey {
        case supplierId = "supplier_entity_id"
        case apiKey = "api_key"
        case apiSecretKey = "api_secret_key"
        case shopName = "shop_name"
        case disposition
        case created
    }
    
    public static func create(
        shopName: String,
        supplierId: String,
        apiKey: String,
        apiSecretKey: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                shopName: shopName,
                supplierId: supplierId,
                apiKey: apiKey,
                apiSecretKey: apiSecretKey
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        supplierId: String,
        shopName: String,
        session: Session?,
        callback: @escaping (Error?, Array<Self>?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(
                supplierId: supplierId,
                shopName: shopName
            ),
            session: session,
            query: nil,
            method: .GET
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let shopName: String
        let supplierId: String
        let apiKey: String
        let apiSecretKey: String
        
        private enum CodingKeys: String, CodingKey {
            case shopName = "shop_name"
            case supplierId = "supplier_id"
            case apiKey = "api_key"
            case apiSecretKey = "api_secret_key"
        }
    }
    
    private struct RetrieveParameters: Codable {
        let supplierId: String
        let shopName: String
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case shopName = "shop_name"
        }
    }
}
