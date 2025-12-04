//
//  SupplierFee.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct SupplierFee: Codable, Sendable {
    
    internal static let path = Supplier.path + "/fee"
    internal static let listPath = SupplierFee.path + "/list"
    
    let supplier: EntityHeadline
    let feePercentage: String
    
    private enum CodingKeys: String, CodingKey {
        case supplier
        case feePercentage = "fee_percentage"
    }
    
    public static func create(
        feePercentage: String,
        supplierId: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                feePercentage: feePercentage,
                supplierId: supplierId
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
                fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        supplierId: String,
        termRateId: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Session?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(
                supplierId: supplierId,
                termRateId: termRateId
            ),
            session: session,
            query: nil,
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
        
    private struct CreatePayload: Codable, Sendable {
        let feePercentage: String
        let supplierId: String
            
        private enum CodingKeys: String, CodingKey {
            case feePercentage = "fee_percentage"
            case supplierId = "supplier_id"
        }
    }
    
    private struct RetrieveParameters: Codable, Sendable {
        let supplierId: String
        let termRateId: String
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case termRateId = "term_rate_id"
        }
    }
}
