//
//  Commitment.swift
//  
//
//  Created by Kayla Hoyet on 8/4/21.
//

import Foundation

public struct Commitment: Codable {
    
    internal static let path = "/commitment"
    
    let setup: Setup
    let created: String
    let creatingAgentId: Int
    let public_id: String
    let committedHuman: Human
    let recurringPayment: String
    let currencyISO4217: String
    
    private enum CodingKeys: String, CodingKey {
        case setup
        case created
        case creatingAgentId = "creating_agent_id"
        case public_id
        case committedHuman = "committed_human"
        case recurringPayment = "recurring_payment"
        case currencyISO4217 = "currency_iso_4217"
    }
}
