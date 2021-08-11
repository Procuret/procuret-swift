//
//  DirectDebit.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct DirectDebit: Codable {
    
    internal static let path = "/payment/method/direct-debit"
    
    let kernel: PaymentMethodKernel
    let particulars: Particulars
    
    private enum CodingKeys: String, CodingKey {
        case kernel
        case particulars
    }
    
    public static func create(
        bsbCode: String,
        accountNumber: String,
        accountName: String,
        entityId: String,
        authorityId: String?,
        callback: @escaping (Error?, DirectDebit?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(bsbCode: bsbCode,
                accountNumber: accountNumber, accountName:
                accountName, entityId: entityId, authorityId:
                authorityId),
            session: nil,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }

    private struct CreatePayload: Codable {
        let bsbCode: String
        let accountNumber: String
        let accountName: String
        let entityId: String
        let authorityId: String?
        
        private enum CodingKeys: String, CodingKey {
            case bsbCode = "bsb"
            case accountNumber = "account_number"
            case accountName = "account_name"
            case entityId = "entity_id"
            case authorityId = "authority_id"
        }
    }
}
