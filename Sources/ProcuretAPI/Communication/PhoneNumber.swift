//
//  PhoneNumber.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//

import Foundation

public struct PhoneNumber: Codable, Equatable {
    
    internal static let path = "/phone-number"
    
    public let phoneId: Int
    public let digits: String
    public let confirmed: Bool?
    public let confirmationRequired: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case phoneId = "indexid"
        case digits
        case confirmed
        case confirmationRequired = "confirmation_required"
    }
    
    public static func create (
        digits: String,
        session: SessionRepresentative?,
        callback: @escaping (Error?, PhoneNumber?) -> Void,
        debugEmail: String? = nil,
        endpoint: ApiEndpoint = ApiEndpoint.live
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(digits: digits, debugEmail: debugEmail),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let digits: String
        let debugEmail: String?
        
        private enum CodingKeys: String, CodingKey {
            case digits = "phone"
            case debugEmail = "debug_email"
        }
    }
}
