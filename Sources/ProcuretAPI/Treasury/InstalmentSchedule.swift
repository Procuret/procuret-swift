//
//  InstalmentSchedule.swift
//  
//
//  Created by Kayla Hoyet on 8/30/21.
//

import Foundation
import PDFKit

public struct InstalmentSchedule: Codable, Equatable {
    
    internal static let path = "/instalment-schedule"
    internal static let pdfPath = Self.path + "/pdf"
    
    public let seriesId: String
    public let lines: Array<DealLedgerLine>
    public let hasInterest: Bool
    public let totalRow: ScheduleTotalRow
    
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
        callback: @Sendable @escaping (Error?, Self?) -> Void
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
    
    public static func retrievePDF(
        seriesId: String,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, PDFDocument?) -> Void
    ) {
        
        Request.make(
            path: Self.pdfPath,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [UrlParameter(seriesId, key: "series_id")]
            ),
            method: .GET,
            endpoint: endpoint,
            then: { (error: Error?, data: Data?) in
                
                guard let data = data else {
                    callback(
                        error ?? ProcuretError(.inconsistentState),
                        nil
                    )
                    return
                }
                
                let pdf = PDFDocument(data: data)
                
                callback(nil, pdf)
                
                return

            }
        )
        
    }
    
    public static func retrievePDF(
        series: PaymentSeries,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, PDFDocument?) -> Void
    ) {
        
        return Self.retrievePDF(
            seriesId: series.publicId,
            session: session,
            endpoint: endpoint,
            callback: callback
        )
        
    }
    
    public static func retrievePDF(
        schedule: InstalmentSchedule,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, PDFDocument?) -> Void
    ) {
        
        return Self.retrievePDF(
            seriesId: schedule.seriesId,
            session: session,
            endpoint: endpoint,
            callback: callback
        )

    }
    
}
