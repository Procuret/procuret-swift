//
//  BECSDirectDebit.swift
//  
//
//  Created by Kayla Hoyet on 8/10/21.
//

import Foundation


public struct BECSDirectDebit: UnderpinnedByMethodKernel {
    
    internal static let path = "/payment/method/becs-direct-debit"
    
    public let kernel: PaymentMethodKernel
    public let details: BECSAccountDetails
    
    public var friendlyDescription: String { get {
        return "Account ..." + self.details.last4
    } }
    
    public var endsIn: String { get { return self.details.last4 } }
    
    private enum CodingKeys: String, CodingKey {
        case kernel
        case details = "account_details"
    }
    
    public static func create(
        bsbCode: String,
        accountNumber: String,
        accountName: String,
        authorityAgentId: Int,
        timeMandateAccepted: Int,
        entityId: Int?,
        callback: @escaping (Error?, BECSDirectDebit?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                bsbCode: bsbCode,
                accountNumber: accountNumber,
                accountName: accountName,
                authorityAgentId: authorityAgentId,
                timeMandateAccepted: timeMandateAccepted,
                entityId: entityId
            ),
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
        let authorityAgentId: Int
        let timeMandateAccepted: Int
        let entityId: Int?
        
        private enum CodingKeys: String, CodingKey {
            case bsbCode = "bsb"
            case accountNumber = "account_number"
            case accountName = "account_name"
            case authorityAgentId = "authority_agent_id"
            case timeMandateAccepted = "time_mandate_accepted"
            case entityId = "entity_id"
        }
    }
}
