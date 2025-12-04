//
//  Authorisation.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct SupplierAuthorisation: Codable, Sendable {
    
    internal static let path = "/supplier/authorisation"
    
    public static func create(
        supplierId: Int,
        authorise: Bool,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                supplierId: supplierId,
                authorise: authorise
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, _ in
            callback(error)
        }
    }
    
    private struct CreatePayload: Codable, Sendable {
        let supplierId: Int
        let authorise: Bool
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case authorise
        }
    }
}
