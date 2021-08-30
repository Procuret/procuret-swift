//
//  ScheduleTotalRow.swift
//  
//
//  Created by Kayla Hoyet on 8/30/21.
//

import Foundation

public struct ScheduleTotalRow: Codable {
    let totalPayments: String
    let totalPrincipal: String
    let totalInterest: String
    let denomination: Currency
    
    private enum CodingKeys: String, CodingKey {
        case totalPayments = "total_payments"
        case totalPrincipal = "total_principal"
        case totalInterest = "total_interest"
        case denomination
    }
}
