//
//  ImpliedIndustry.swift
//  
//
//  Created by Kayla Hoyet on 7/30/21.
//

import Foundation

public struct ImpliedCustomerIndustry: Codable {
    
    internal static let path = "supplier/implied-customer-industry"
    
    let indexid: Int
    let industryId: Int
    
    public enum CodingKeys: String, CodingKey {
        case indexid
        case industryId = "industry_id"
    }
    
    public static func create(
        supplierId: Int,
        industryId: Int,
        callback: @escaping (Error?, ImpliedCustomerIndustry?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(supplierId: supplierId, industryId: industryId),
            session: nil,
            query: nil,
            method: .POST
        ) { error, data in
                fatalError("Not implemented")
        }
    }
        
    private struct CreatePayload: Codable {
        let supplierId: Int
        let industryId: Int
            
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case industryId = "industry_id"
        }
    }
}
