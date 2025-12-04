//
//  LedgerLine.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//  Modified by HJeremy 12 Apr 2023
//

import Foundation

public struct DealLedgerLine: Codable, Identifiable, Equatable, Sendable {
    
    public enum PaymentStatus {
        case notDue
        case dueUnpaid
        case overdue
        case paid
        case prolongedPaymentInProgress
    }
    
    public let sequence: Int
    public let date: String
    public let due24hrsStarting: Date
    public let rawNominalPayment: String
    public let rawOpeningBalance: String
    public let rawInterestPaid: String
    public let rawPrincipalPaid: String
    public let rawClosingBalance: String
    public let rawPaid: String
    public let commitmentPublicId: String
    public let isBespoke: Bool
    public let unresolvedProlongedPayment: ProlongedPayment?
    public let denomination: Currency
    
    public var id: String { get {
        return "\(self.commitmentPublicId)_\(self.sequence)"
    } }
    
    public var nominalPayment: Amount { get { return Amount(
        magnitude: Decimal(string: self.rawNominalPayment) ?? -1,
        denomination: self.denomination
    ) } }
    
    public var openingBalance: Amount { get { return Amount(
        magnitude: Decimal(string: self.rawOpeningBalance) ?? -1,
        denomination: self.denomination
    ) } }
    
    public var interestPaid: Amount { get { return Amount(
        magnitude: Decimal(string: self.rawInterestPaid) ?? -1,
        denomination: self.denomination
    ) } }
    
    public var principalPaid: Amount { get { return Amount(
        magnitude: Decimal(string: self.rawPrincipalPaid) ?? -1,
        denomination: self.denomination
    ) } }
    
    public var closingBalance: Amount { get { return Amount(
        magnitude: Decimal(string: self.rawClosingBalance) ?? -1,
        denomination: self.denomination
    ) } }
    
    public var paid: Amount { get { return Amount(
        magnitude: Decimal(string: self.rawPaid) ?? -1,
        denomination: self.denomination
    ) } }
    
    public var balanceOutstanding: Amount {
        return self.nominalPayment - self.paid
    }
    
    public var balanceDueAndOutstanding: Amount {
        guard self.due24hrsStarting < Date.now else {
            return .zero(in: self.denomination)
        }
        return self.balanceOutstanding
    }
    
    public var status: PaymentStatus { get { return self.deriveStatus() } }

    public enum CodingKeys: String, CodingKey {
        case sequence
        case date
        case due24hrsStarting = "due_24hrs_starting"
        case rawNominalPayment = "nominal_payment"
        case rawOpeningBalance = "opening_balance"
        case rawInterestPaid = "interest_paid"
        case rawPrincipalPaid = "principal_paid"
        case rawClosingBalance = "closing_balance"
        case rawPaid = "paid"
        case commitmentPublicId = "commitment_public_id"
        case isBespoke = "is_bespoke"
        case unresolvedProlongedPayment = "unresolved_prolonged_payment"
        case denomination
    }
    
    private func deriveStatus() -> PaymentStatus {
        
        if self.balanceOutstanding.magnitude <= 0 { return .paid }
        
        if self.due24hrsStarting > Date.now { return .notDue }
        if Date.now < self.due24hrsStarting.addingTimeInterval(60 * 60 * 24) {
            return .dueUnpaid
        }
        return .overdue

    }

}
