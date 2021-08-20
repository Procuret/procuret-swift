//
//  Method.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct PaymentMethod: Codable {
    
    internal static let path = "/payment/method"
    internal static let listPath = PaymentMethod.path + "/list"
    
    internal static func retrieve(
        publicId: String,
        session: Session?,
        callback: @escaping (Error?, PaymentMethod?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(publicId: publicId),
            session: session,
            query: nil,
            method: .GET
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct RetrieveParameters: Codable {
        let publicId: String
        
        private enum CodingKeys: String, CodingKey {
            case publicId = "public_id"
        }
    }
}
