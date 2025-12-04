//
//  Division.swift
//  
//
//  Created by Kayla Hoyet on 4/28/23.
//

import Foundation

public struct PayNowDivision: Codable, Sendable {
    
    public let method: PaymentMethodHeadline
    public let magnitude: String
    
    public enum CodingKeys: String, CodingKey {
        case method
        case magnitude
    }
}
