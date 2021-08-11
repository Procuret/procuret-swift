//
//  Shop.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct ShopifyShop: Codable {
    
    internal static let path = "/shopify/shop"
    
    let shopName: String
    let created: ProcuretTime
    let supplierId: String
    let active: Bool
    let disposition: Disposition
    
    private enum CodingKeys: String, CodingKey {
        case shopName = "shop_name"
        case created
        case supplierId = "supplier_id"
        case active
        case disposition
    }
    
    public static func create(
        supplierId: String,
        name: String,
        active: Bool,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(supplierId: supplierId, name: name,
                active: active),
            session: session,
            query: nil,
            method: .POST
            ) { error, data in
                fatalError("Not implemented")
            }
        }
        
        private struct CreatePayload: Codable {
            let supplierId: String
            let name: String
            let active: Bool
            
            private enum CodingKeys: String, CodingKey {
                case supplierId = "supplier_id"
                case name
                case active
        }
    }
}

