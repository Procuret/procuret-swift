//
//  DirectDebit.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct BankAccount: UnderpinnedByMethodKernel {
    
    internal static let path = "/payment/method/direct-debit"
    
    public let kernel: PaymentMethodKernel
    public let particulars: Particulars
    
    public var friendlyDescription: String { get {
        return "Account ..." + self.particulars.endingIn
    } }

    public var endsIn: String { get {
        return self.particulars.endingIn
    } }
    
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
        session: Session?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, BankAccount?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                bsbCode: bsbCode,
                accountNumber: accountNumber,
                accountName: accountName,
                entityId: entityId,
                authorityId: authorityId
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
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
