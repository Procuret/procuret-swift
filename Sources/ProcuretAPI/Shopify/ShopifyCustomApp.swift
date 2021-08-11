//
//  ShopifyCustomApp.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct ShopifyCustomApp: Codable {
    
    internal static let path = "/shopify/custom-app"
    
    let supplierId: String
    let apiKey: String
    let apiSecretKey: String
    let shopName: String
    let disposition: Disposition
    let created: ProcuretTime
    
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
            payload: CreatePayload(shopName: shopName, supplierId:
                supplierId, apiKey: apiKey, apiSecretKey: apiSecretKey),
            session: session,
            query: nil,
            method: .POST
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
}
