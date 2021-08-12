//
//  UniversalRate.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct UniversalRate: Codable {
    
    internal static let path = "/admin/supplier/universal-rate"
    
    let supplierId: Int
    let rate: Decimal
    
    private enum CodingKeys: String, CodingKey {
        case supplierId = "supplier_id"
        case rate = "percentage_rate"
    }
}
