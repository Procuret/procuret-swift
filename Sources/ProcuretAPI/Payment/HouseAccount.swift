//
//  HouseAccount.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//  Modified by Hugh Jeremy 27 Mar 2022
//

import Foundation


public struct HouseAccount: Decodable, Sendable {
    
    internal static let path = "/house-account"
    
    let created: Date
    let account: BankAccount
    
    private enum CodingKeys: String, CodingKey {
        case created
        case account
    }
    
    public static func create(
        currency: Currency,
        bsbCode: String,
        accountNumber: String,
        accountName: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, HouseAccount?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                currency: currency,
                bsbCode: bsbCode,
                accountNumber: accountNumber,
                accountName: accountName
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
        currency: Currency,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, HouseAccount?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(currency: currency),
            session: session,
            query: nil,
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable, Sendable {
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
    
    private struct RetrieveParameters: Codable, Sendable {
        let currency: Currency
        
        private enum CodingKeys: String, CodingKey {
            case currency
        }
    }
}
