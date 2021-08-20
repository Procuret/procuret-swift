//
//  AuthRequest.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct ShopifyAuthorisationRequest: Codable {
    
    internal static let path = "/shopify/authorisation-request"
    
    let loginUrl: String
    let publicId: String
    
    private enum CodingKeys: String, CodingKey {
        case loginUrl = "login_url"
        case publicId = "public_id"
    }
    
    public static func create(
        supplierId: String,
        shopName: String,
        beneficiaryAgentId: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(supplierId: supplierId,
                shopName: shopName, beneficiaryAgentId: beneficiaryAgentId),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    public static func retrieveByNonce(
        nonce: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveNonceParameters(nonce: nonce),
            session: session,
            query: nil,
            method: .GET
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let supplierId: String
        let shopName: String
        let beneficiaryAgentId: String
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case shopName = "shop_name"
            case beneficiaryAgentId = "beneficiary_agent_id"
        }
    }
    
    private struct RetrieveNonceParameters: Codable {
        let nonce: String
        
        private enum CodingKeys: String, CodingKey {
            case nonce
        }
    }
}
