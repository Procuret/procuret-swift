//
//  ProspectivePayment.swift
//  
//
//  Created by Kayla Hoyet on 8/5/21.
//

import Foundation

public struct ProspectivePayment: Codable {
    
    internal static let path = "/credit/prospective-payment"
    
    public static func retrieve(
        principle: Float,
        cycle: Cycle,
        supplierId: Int,
        periods: Int,
        callback: @escaping (Error?, ProspectivePayment?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: retrieveParameters(
                principle: principle,
                cycle: cycle,
                supplierId: supplierId,
                periods: periods
            ),
            session: nil,
            query: nil,
            method: .GET
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct retrieveParameters: Codable {
        let principle: Float
        let cycle: Cycle
        let supplierId: Int
        let periods: Int
        
        private enum CodingKeys: String, CodingKey {
            case principle
            case cycle
            case supplierId = "supplier_id"
            case periods
        }
    }
}
