//
//  TermRate.swift
//
//
//  Created by Kayla Hoyet on 8/12/21.
//  Modified by Hugh Jeremy 27 Mar 2022
//

import Foundation

public struct TermRate: Codable, Hashable, Identifiable, Equatable {
    
    internal static let path = "/term-rate"
    internal static let listPath = "/term-rate/list"
    
    public let supplierId: Int
    public let periods: Int
    public let rawPeriodsPerYear: String
    
    public var periodsPerYear: Decimal { get {
        return Decimal(string: self.rawPeriodsPerYear) ?? -1
    } }

    private enum CodingKeys: String, CodingKey {
        case supplierId = "supplier_entity_id"
        case periods
        case rawPeriodsPerYear = "periods_in_year"
    }
    
    public var id: String { get {
        return "\(self.supplierId)_\(self.periods)"
    } }

}
