//
//  SettlementAccount.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct SettlementAccount: Codable {
    
    internal static let path = Supplier.path + "/settlement-account"
    
    let created: ProcuretTime
    let supplier: EntityHeadline
    let creator: HumanHeadline
    let account: DirectDebit
    
    private enum CodingKeys: String, CodingKey {
        case created
        case supplier
        case creator
        case account
    }
    
    public static func create(
        supplierId: String,
        accountId: String,
        session: Session?,
        callback: @escaping (Self?, Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                supplierId: supplierId,
                accountId: accountId
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
                fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        supplierId: String,
        session: Session?,
        callback: @escaping (Self?, Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(supplierId: supplierId),
            session: session,
            query: nil,
            method: .GET
        ) { error, data in
            fatalError("Not implemented")
        }
    }
            
    private struct CreatePayload: Codable {
        let supplierId: String
        let accountId: String
                
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case accountId = "account_id"
        }
    }
    
    private struct RetrieveParameters: Codable {
        let supplierId: String
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
        }
    }
}
