//
//  SupplierFee.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct SupplierFee: Codable {
    
    internal static let path = Supplier.path + "/fee"
    
    let supplier: EntityHeadline
    let feePercentage: String
    
    private enum CodingKeys: String, CodingKey {
        case supplier
        case feePercentage = "fee_percentage"
    }
    
    public static func create(
        feePercentage: String,
        supplierId: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(feePercentage: feePercentage,
                supplierId: supplierId),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
                fatalError("Not implemented")
        }
    }
        
    private struct CreatePayload: Codable {
        let feePercentage: String
        let supplierId: String
            
        private enum CodingKeys: String, CodingKey {
            case feePercentage = "fee_percentage"
            case supplierId = "supplier_id"
        }
    }
}
