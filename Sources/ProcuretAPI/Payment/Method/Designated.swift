//
//  Designated.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct DesignatedPaymentMethod: Codable {
    
    internal static let path = PaymentSeries.path + "/designated-method"
    
    let seriesId: String
    let methodId: String
    
    public enum CodingKeys: String, CodingKey {
        case seriesId = "series_id"
        case methodId = "method_id"
    }
    
    public static func create (
        seriesId: String,
        methodId: String,
        session: Session?,
        callback: @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                seriesId: seriesId,
                methodId: methodId
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
        
    private struct CreatePayload: Codable {
        let seriesId: String
        let methodId: String
            
        private enum CodingKeys: String, CodingKey {
            case seriesId = "series_id"
            case methodId = "method_id"
        }
    }
}
