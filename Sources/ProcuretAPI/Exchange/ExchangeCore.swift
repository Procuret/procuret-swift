//
//  ExchangeCore.swift
//  
//
//  Created by Kayla Hoyet on 3/9/23.
//

import Foundation

public struct ExchangeCore: Codable, Sendable {
    
    public let publicId: String
    public let created: Date
    public let supplier: EntityHeadline
    public let amount: Amount
    public let description: String
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case created
        case supplier
        case amount
        case description
    }

}
