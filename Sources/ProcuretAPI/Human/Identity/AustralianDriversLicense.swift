//
//  File.swift
//  
//
//  Created by Hugh on 11/5/2023.
//

import Foundation


public struct AustralianDriversLicense {
    
    internal static let path: String =
        "\(HumanIdentityDocument.path)/au-license"
    
    public static func create(
        authenticatedBy session: SessionRepresentative,
        identifying human: Human,
        licenseNumber: String,
        cardNumber: String,
        at endpoint: ApiEndpoint = .live,
        then callback: @Sendable @escaping (Error?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            payload: Self.CreatePayload(
                human_id: human.agentId,
                license_number: licenseNumber,
                card_number: cardNumber
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, _ in callback(error) }

    }
    
    private struct CreatePayload: Encodable {
        
        let human_id: Int
        let license_number: String
        let card_number: String
        
    }
    
}
