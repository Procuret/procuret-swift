//
//  PhoneConfirmation.swift
//  
//
//  Created by Kayla Hoyet on 10/6/22.
//

import Foundation

public struct PhoneConfirmation: Codable, Sendable {
    
    internal static let path = "/phone-number/confirm"
    
    public static func create (
        phoneId: Int,
        code: String,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?) -> Void
    ) {
        Request.make(
            path: "/phone-number/confirm",
            payload: CreatePayload(
                phoneId: phoneId,
                code: code
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) {
            error, data in
            callback(error)
            return
        }
    }
    
    private struct CreatePayload: Codable, Sendable {
        let phoneId: Int
        let code: String
        
        private enum CodingKeys: String, CodingKey {
            case phoneId = "phone_id"
            case code
        }
    }
}
