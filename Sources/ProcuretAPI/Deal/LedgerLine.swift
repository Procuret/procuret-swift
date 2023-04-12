//
//  LedgerLine.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct DealLedgerLine: Codable, Identifiable {
    
    public let sequence: Int
    public let date: String
    public let due24hrsStarting: Date
    public let nominalPayment: String
    public let openingBalance: String
    public let interestPaid: String
    public let principalPaid: String
    public let closingBalance: String
    public let commitmentPublicId: String
    public let payment: Payment?
    public let denomination: Currency
    
    public var id: String { get { return self.commitmentPublicId } }
    
    public enum CodingKeys: String, CodingKey {
        case sequence
        case date
        case due24hrsStarting = "due_24hrs_starting"
        case nominalPayment = "nominal_payment"
        case openingBalance = "opening_balance"
        case interestPaid = "interest_paid"
        case principalPaid = "principal_paid"
        case closingBalance = "closing_balance"
        case commitmentPublicId = "commitment_public_id"
        case payment
        case denomination
    }

}
