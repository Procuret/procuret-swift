//
//  BusinessAgreement.swift
//  
//
//  Created by Kayla Hoyet on 8/4/21.
//

import Foundation

public struct BusinessAgreement: Codable {
    
    internal static let path = "/business/agreement"
    
    let businessId: String
    let signaturePNG: String
    
    private enum CodingKeys: String, CodingKey {
        case businessId = "business_id"
        case signaturePNG = "signature_base64PNG"
    }
    
    public static func create(
        businessId: String,
        signaturePNG: String,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, String?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                businessId: businessId,
                signaturePNG: signaturePNG
            ),
            session: nil,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let businessId: String
        let signaturePNG: String
        
        private enum CodingKeys: String, CodingKey {
            case businessId = "business_id"
            case signaturePNG = "signature_base64PNG"
        }
    }
}
