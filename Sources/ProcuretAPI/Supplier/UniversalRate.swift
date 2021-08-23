//
//  UniversalRate.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct UniversalRate: Codable {
    
    internal static let path = "/admin/supplier/universal-rate"
    
    public static func create(
        supplierId: Int,
        rate: Decimal,
        callback: @escaping (Error?, Data?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(supplierId: supplierId, rate: rate),
            session: nil,
            query: nil,
            method: .POST
        ) { error, data in
                fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let supplierId: Int
        let rate: Decimal
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case rate = "percentage_rate"
        }
    }
}
