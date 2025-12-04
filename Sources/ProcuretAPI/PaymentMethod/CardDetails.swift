//
//  CardDetails.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct CardDetails: Codable, Sendable {
    
    public let last4: String
    public let brand: String?
    public let funding: String
    public let expiryMonth: Int
    public let expiryYear: Int
    public let custodianId: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case last4 = "last_4"
        case brand
        case funding
        case expiryMonth = "expiry_month"
        case expiryYear = "expiry_year"
        case custodianId = "custodian_id"
        
    }
    
}
