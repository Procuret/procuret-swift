//
//  MaxTransactionValue.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct MaxTransactionValue: Codable {
    
    internal static let path = "/supplier/max-transaction-size"
    
    let supplierId: String
    let magnitude: String
    let created: ProcuretTime
    let denomination: Currency
    let active: Bool
    let disposition: Disposition
    
    private enum CodingKeys: String, CodingKey {
        case supplierId = "supplier_id"
        case magnitude
        case created
        case denomination
        case active
        case disposition
    }
    
    public static func create(
        denomination: Currency,
        supplierId: String,
        magnitude: String,
        active: Bool,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(denomination: denomination,
                supplierId: supplierId, magnitude: magnitude,
                active: active),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
                fatalError("Not implemented")
        }
    }
            
    private struct CreatePayload: Codable {
        let denomination: Currency
        let supplierId: String
        let magnitude: String
        let active: Bool
                
        private enum CodingKeys: String, CodingKey {
            case denomination
            case supplierId = "supplier_id"
            case magnitude
            case active
        }
    }
}