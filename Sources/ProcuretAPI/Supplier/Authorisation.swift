//
//  Authorisation.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct SupplierAuthorisation: Codable {
    
    internal static let path = "/supplier/authorisation"
    
    public static func create(
        supplierId: String,
        authorise: Bool,
        session: Session?,
        callback:  @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                supplierId: supplierId,
                authorise: authorise
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let supplierId: String
        let authorise: Bool
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case authorise
        }
    }
}
