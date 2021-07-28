//
//  QuickStats.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct QuickStats: Codable {
    
    let humanCount: Int
    let businessCount: Int
    let supplierCount: Int
    let eoiReceived: Bool
    
    public enum CodingKeys: String, CodingKey {
        case humanCount = "human_count"
        case businessCount = "business_count"
        case supplierCount = "supplier_count"
        case eoiReceived = "eoi_received"
    }
    
    public static func retrieve (
        callback: @escaping (Error?, QuickStats?) -> Void
        ) {
        fatalError("Not implemented")
        }
}
