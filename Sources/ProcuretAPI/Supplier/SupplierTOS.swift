//
//  SupplierTOS.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct SupplierTOS: Codable {
    
    internal static let path = "/supplier/tos"
    
    public static func create(
        supplierId: Int,
        markdown: String,
        callback: @escaping (Error?, SupplierTOS?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(supplierId: supplierId,
                markdown: markdown),
            session: nil,
            query: nil,
            method: .POST
        ) { error, data in
                fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let supplierId: Int
        let markdown: String
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case markdown
        }
    }
}
