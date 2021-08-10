//
//  BECSDirectDebit.swift
//  
//
//  Created by Kayla Hoyet on 8/10/21.
//

import Foundation

public struct BECSDirectDebit: Codable {
    
    internal static let path = "/payment/method/becs-direct-debit"
    
    let kernel: PaymentMethodKernel
    let last4: String
    let bsb: String
    
    private enum CodingKeys: String, CodingKey {
        case kernel
        case last4 = "last_4"
        case bsb
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
        fatalError("Not implemented")
    }
}
