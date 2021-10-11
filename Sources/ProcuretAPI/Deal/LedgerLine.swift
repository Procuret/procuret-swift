//
//  LedgerLine.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct DealLedgerLine: Codable {
    
    let sequence: Int
    let date: String
    let nominalPayment: String
    let openingBalance: String
    let interestPaid: String
    let principalPaid: String
    let closingBalance: String
    let commitmentPublicId: String
    let payment: Payment?
    
    public enum CodingKeys: String, CodingKey {
        case sequence
        case date
        case nominalPayment = "nominal_payment"
        case openingBalance = "opening_balance"
        case interestPaid = "interest_paid"
        case principalPaid = "principal_paid"
        case closingBalance = "closing_balance"
        case commitmentPublicId = "commitment_public_id"
        case payment
    }
}
