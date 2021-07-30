//
//  DefaultDescription.swift
//  
//
//  Created by Kayla Hoyet on 7/30/21.
//

import Foundation

public struct DefaultDescription: Codable {
    
    internal static let path = "/supplier/default-description"
    
    let supplierId: Int
    let description: String
    
    public enum CodingKeys: String, CodingKey {
        case supplierId = "supplier_id"
        case description
    }
}
