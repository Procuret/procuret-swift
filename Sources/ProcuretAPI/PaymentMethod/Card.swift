//
//  Card.swift
//  
//
//  Created by Kayla Hoyet on 8/10/21.
//

import Foundation

public struct Card: UnderpinnedByMethodKernel {
    
    internal static let path = "/payment/method/card"
    
    public let kernel: PaymentMethodKernel
    public let details: CardDetails
    
    public var endsIn: String { get {
        return self.details.last4
    } }
    
    public var friendlyDescription: String { get {
        return self.details.brand ?? "Card" + " ..." + self.details.last4
    } }

    private enum CodingKeys: String, CodingKey {
        case kernel
        case details = "card_details"
    }
    
    public static func createFromPlainDetails(
        entityId: Int?,
        authorityAgentId: Int,
        cardNumber: String,
        expiryMonth: String,
        expiryYear: String,
        cvc: String,
        postalCode: String,
        session: Session?,
        callback: @escaping (Error?, Card?) -> Void
    ) {
        Request.make(
            path: "/payment/method/card/plain",
            payload: CreatePayload(
                entityId: entityId,
                authorityAgentId: authorityAgentId,
                cardNumber: cardNumber,
                expiryMonth: expiryMonth,
                expiryYear: expiryYear,
                cvc: cvc,
                postalCode: postalCode
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    private struct CreatePayload: Codable {
        let entityId: Int?
        let authorityAgentId: Int
        let cardNumber: String
        let expiryMonth: String
        let expiryYear: String
        let cvc: String
        let postalCode: String
        
        private enum CodingKeys: String, CodingKey {
            case entityId = "entity_id"
            case authorityAgentId = "authority_agent_id"
            case cardNumber = "card_number"
            case expiryMonth = "expiry_month"
            case expiryYear = "expiry_year"
            case cvc = "cvc"
            case postalCode = "postcode"
        }
    }
}
