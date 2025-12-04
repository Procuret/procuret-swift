//
//  PaymentAdvice.swift
//  
//
//  Created by Kayla Hoyet on 8/5/21.
//

import Foundation

public struct PaymentAdvice: Codable, Sendable {
    
    internal static let path = Supplier.path + "/payment-advice"
    internal static let listPath = PaymentAdvice.path + "/list"
    
    let seriesId: String
    let created: Date
    
    private enum CodingKeys: String, CodingKey {
        case seriesId = "series_id"
        case created
    }
    
    public static func create(
        seriesId: String,
        recipientEmail: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                seriesId: seriesId,
                recipientEmail: recipientEmail
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    public static func retrieveMany(
        seriesId: String,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, Array<Self>?) -> Void
    ) {
        Request.make(
            path: self.listPath,
            payload: RetrieveManyParameters(seriesId: seriesId),
            session: session,
            query: nil,
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable, Sendable {
        let seriesId: String
        let recipientEmail: String
        
        private enum CodingKeys: String, CodingKey {
            case seriesId = "series_id"
            case recipientEmail = "recipient_email"
        }
    }
    
    private struct RetrieveManyParameters: Codable, Sendable {
        let seriesId: String
        
        private enum CodingKeys: String, CodingKey {
            case seriesId = "series_id"
        }
    }
}
