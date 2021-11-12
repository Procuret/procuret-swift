//
//  File.swift
//  
//
//  Created by Kayla Hoyet on 11/12/21.
//

import Foundation

public struct SellStage: Codable {
    
    let human: Human?
    let entity: Entity?
    let supplier: Supplier
    let rateGroup: Dictionary<String, Int>?  //rateGroup type needs investigation. Likely to change. Suspect Dict or Enum
    let rates: Array<TermRate>
    let instalmentLink: InstalmentLink?
    let methods: Array<PaymentMethod>
    
    private enum CodingKeys: String, CodingKey {
        case human
        case entity
        case supplier
        case rateGroup = "rate_group"
        case rates
        case instalmentLink = "instalment_link"
        case methods
    }
}
