//
//  Amount.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct Amount: Codable {
    
    let magnitude: Decimal
    let currency: Currency
    
    public enum CodingKeys: String, CodingKey {
        case magnitude
        case currency
    }
}
