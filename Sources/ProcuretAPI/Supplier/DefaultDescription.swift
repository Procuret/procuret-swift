//
//  DefaultDescription.swift
//  
//
//  Created by Kayla Hoyet on 7/30/21.
//

import Foundation

public struct DefaultDescription: Codable, Sendable {
    
    internal static let path = "/supplier/default-description"
    
    public static func create(
        supplierId: Int,
        description: String,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, Data?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                supplierId: supplierId,
                description: description
            ),
            session: nil,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable, Sendable {
        let supplierId: Int
        let description: String
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplierId"
            case description
        }
    }
}
