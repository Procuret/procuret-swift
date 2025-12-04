//
//  InstalmentAttempt.swift
//  
//
//  Created by Kayla Hoyet on 4/13/23.
//  Modified by HJ on 14 Apr 2023
//

import Foundation

public struct InstalmentPaymentAttempt: Codable, Sendable {
    
    internal static let path = PaymentSeries.path + "/payment-attempt"
    
    public static func make(
        methodId: String,
        seriesId: String,
        amount: Amount,
        due24hrsStarting: Date,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, Outcome?) -> Void
    ) {
        
        Request.make(
            path: self.path,
            payload: Self.CreatePayload(
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
            Request.decodeResponse(e, d, Outcome.self, callback)
            return
        }
        
        return

    }
    
    private struct CreatePayload: Codable, Sendable {
        
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
    
    public enum Outcome: Decodable {
        
        case failedPayment(FailedPayment)
        case payment(TreasuryPayment)
        case prolongedPayment(ProlongedPayment)
        
        private enum RecordType: Int, Decodable {
            case payment = 1
            case failed = 2
            case prolonged = 3
        }
        
        private enum CodingProbe: String, CodingKey {
            case expectedCompletion = "expected_completion"
            case failureMode = "failure_mode"
        }
        
        public init(from decoder: Decoder) throws {
    
            let probeContainer = try decoder.container(
                keyedBy: CodingProbe.self
            )
            
            func deriveType() -> RecordType {
                
                if probeContainer.contains(.expectedCompletion) {
                    return .prolonged
                }
                
                if probeContainer.contains(.failureMode) {
                    return .failed
                }
                
                return .payment
                
            }
          
            let type = deriveType()
          
            switch type {
                
            case .failed:
                self = Self.failedPayment(
                    try FailedPayment(from: decoder)
                )
            case .prolonged:
                self = Self.prolongedPayment(
                    try ProlongedPayment(from: decoder)
                )
            case .payment:
                self = Self.payment(
                    try TreasuryPayment(from: decoder)
                )
            }
    
        }
        
    }

    
}
