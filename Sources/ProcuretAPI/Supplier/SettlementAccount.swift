//
//  SettlementAccount.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//  Modified by Hugh Jeremy 27 Mar 2022
//

import Foundation

public struct SettlementAccount: Decodable {
    
    internal static let path = Supplier.path + "/settlement-account"
    
    let created: Date
    let supplier: EntityHeadline
    let creator: HumanHeadline
    let account: BankAccount
    
    private enum CodingKeys: String, CodingKey {
        case created
        case supplier
        case creator
        case account
    }
    
    public static func create(
        supplierId: String,
        accountId: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
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
            method: .POST,
            endpoint: endpoint
        ) { error, data in
                fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        supplierId: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Self?, Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(supplierId: supplierId),
            session: session,
            query: nil,
            method: .GET,
            endpoint: endpoint
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
