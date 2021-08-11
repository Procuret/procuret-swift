//
//  HouseAccount.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct HouseAccount: Codable {
    
    internal static let path = "/house-account"
    
    let created: ProcuretTime
    let account: DirectDebit
    
    private enum CodingKeys: String, CodingKey {
        case created
        case account
    }
    
    public static func create(
        currency: Currency,
        bsbCode: String,
        accountNumber: String,
        accountName: String,
        session: Session?,
        callback: @escaping (Error?, HouseAccount?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(currency: currency,
                bsbCode: bsbCode, accountNumber: accountNumber,
                accountName: accountName),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let currency: Currency
        let bsbCode: String
        let accountNumber: String
        let accountName: String
        
        private enum CodingKeys: String, CodingKey {
            case currency
            case bsbCode = "bsb"
            case accountNumber = "account_number"
            case accountName = "account_name"
        }
    }
}
