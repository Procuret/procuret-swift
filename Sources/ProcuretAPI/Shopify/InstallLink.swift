//
//  InstallLink.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct ShopifyInstallLink: Codable {
    
    internal static let path = "/shopify/install-link"
    internal static let listPath = ShopifyInstallLink.path + "/list"
    internal static let exhaustPath = ShopifyInstallLink.path + "/exhaustion"
    internal static let messagePath = ShopifyInstallLink.path + "/message"
    
    let publicId: String
    let created: Date
    let url: String
    let shopName: String
    let exhausted: Bool
    let expired: Bool
    let disposition: Disposition
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case created
        case url
        case shopName = "shop_name"
        case exhausted
        case expired
        case disposition
    }
    
    public static func create(
        url: String,
        shopName: String,
        supplierId: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                url: url,
                shopName: shopName,
                supplierId: supplierId
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
        
    private struct CreatePayload: Codable {
        let url: String
        let shopName: String
        let supplierId: String
            
        private enum CodingKeys: String, CodingKey {
            case url
            case shopName = "shop_name"
            case supplierId = "supplier_id"
        }
    }
}
