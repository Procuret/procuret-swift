//
//  InstalmentSchedule.swift
//  
//
//  Created by Kayla Hoyet on 8/30/21.
//

import Foundation

public struct InstalmentSchedule: Codable {
    let seriesId: String
    let lines: Array<DealLedgerLine>
    let hasInterest: Bool
    let totalRow: ScheduleTotalRow
    
    private enum CodingKeys: String, CodingKey {
        case seriesId = "series_id"
        case lines
        case hasInterest = "has_interest"
        case totalRow = "total_row"
    }
    
    public static func retrieve(
        callback: @escaping (Error?, Self?) -> Void
    ) {
        fatalError("Not implemented")
    }
}
