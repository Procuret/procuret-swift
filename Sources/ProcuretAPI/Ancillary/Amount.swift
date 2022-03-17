//
//  Amount.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct Amount: Codable {
    
    public let magnitude: String
    public let denomination: Currency
    
    public enum CodingKeys: String, CodingKey {
        case magnitude
        case denomination
    }
}
