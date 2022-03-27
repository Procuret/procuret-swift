//
//  File.swift
//  
//
//  Created by Kayla Hoyet on 11/12/21.
//

import Foundation

public struct SellStage: Decodable {
    
    let human: Human?
    let entity: Entity?
    let supplier: Supplier
    let rateGroup: TermRateGroup?
    let rates: Array<TermRate>
    let termsOfService: TOS
    let privacyPolicy: PrivacyPolicy
    let stripeDDR: StripeDDRAgreement
    let instalmentLink: InstalmentLink?
    let methods: Array<PaymentMethod>
    
    private enum CodingKeys: String, CodingKey {
        case human
        case entity
        case supplier
        case rateGroup = "rate_group"
        case rates
        case termsOfService = "terms_of_service"
        case privacyPolicy = "privacy_policy"
        case stripeDDR = "stripe_ddr"
        case instalmentLink = "instalment_link"
        case methods
    }
}
