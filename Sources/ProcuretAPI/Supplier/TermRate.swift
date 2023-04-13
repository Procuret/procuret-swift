//
//  TermRate.swift
//
//
//  Created by Kayla Hoyet on 8/12/21.
//  Modified by Hugh Jeremy 27 Mar 2022
//

import Foundation

public struct TermRate: Codable {
    
    internal static let path = "/term-rate"
    internal static let listPath = "/term-rate/list"
    
    let supplierId: Int
    let periods: Int
    let periodsPerYear: Decimal
    
    private enum CodingKeys: String, CodingKey {
        case supplierId = "supplier_entity_id"
        case periods
        case periodsPerYear = "periods_in_year"
    }
    
}
