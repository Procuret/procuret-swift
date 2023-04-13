//
//  InstalmentAttempt.swift
//  
//
//  Created by Kayla Hoyet on 4/13/23.
//

import Foundation

public struct InstalmentPaymentAttempt: Codable {
    
    internal static let path = PaymentSeries.path + "/payment-attempt"
    
    public static func make(
        methodId: String,
        seriesId: String,
        amount: Amount,
        due24hrsStarting: Date,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, AttemptOutcome?) -> Void
    ) {
        
        typealias AO = AttemptOutcome
        
        Request.make(
            path: self.path,
            payload: CreatePayload(
                methodId: methodId,
                seriesId: seriesId,
                amount: amount,
                due24hrsStarting: due24hrsStarting
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { e, d in
            fatalError("Not implemented.")
            //Request.decodeResponse(e, d, callback, AO)
        }

    }
    
    private struct CreatePayload: Codable {
        
        let methodId: String
        let seriesId: String
        let amount: Amount
        let due24hrsStarting: Date
        
        private enum CodingKeys: String, CodingKey {
            case methodId = "method_id"
            case seriesId = "series_id"
            case amount
            case due24hrsStarting = "due_24hrs_starting"
            
        }
        
    }
}
