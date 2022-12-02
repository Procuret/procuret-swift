//
//  InstalmentSchedule.swift
//  
//
//  Created by Kayla Hoyet on 8/30/21.
//

import Foundation

public struct InstalmentSchedule: Codable {
    
    internal static let path = "/instalment-schedule"
    
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
        seriesId: String,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: "/instalment-schedule",
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [UrlParameter(seriesId, key: "series_id")]
            ),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
            
    }
}
