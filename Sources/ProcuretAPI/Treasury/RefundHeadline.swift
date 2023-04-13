//
//  RefundHeadline.swift
//  
//
//  Created by Kayla Hoyet on 4/13/23.
//

import Foundation

public struct RefundHeadline: Codable, Identifiable {
    
    public let refundId: String
    public let magnitude: String
    
    public var id: String { get { return self.refundId; } }
    
    private enum CodingKeys: String, CodingKey {
        case refundId = "refund_id"
        case magnitude
    }
}
