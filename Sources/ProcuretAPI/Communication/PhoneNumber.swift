//
//  PhoneNumber.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//

import Foundation

public struct PhoneNumber: Codable, Equatable, Identifiable, Hashable,
                           Sendable{
    
    internal static let path = "/phone-number"
    
    public let phoneId: Int
    public let digits: String
    public let confirmed: Bool?
    public let confirmationRequired: Bool?
    
    public var id: Int { return self.phoneId }

    private enum CodingKeys: String, CodingKey {
        case phoneId = "indexid"
        case digits
        case confirmed
        case confirmationRequired = "confirmation_required"
    }
    
    public func replaceForAssociatedHuman(
        authenticatedBy session: SessionRepresentative,
        withNewDigits newDigits: String,
        at endpoint: ApiEndpoint = .live,
        callback: @Sendable @escaping (Error?, Self?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            payload: UpdateForHumanPayload(
                phone_id: self.phoneId,
                new_number: newDigits
            ), session: session,
            query: nil,
            method: .PUT,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
        }
        
        return
        
    }
    
    public static func create (
        digits: String,
        session: SessionRepresentative?,
        callback: @Sendable @escaping (Error?, PhoneNumber?) -> Void,
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

    private struct CreatePayload: Codable, Sendable {
        let digits: String
        let debugEmail: String?
        
        private enum CodingKeys: String, CodingKey {
            case digits = "phone"
            case debugEmail = "debug_email"
        }
    }
    
    private struct UpdateForHumanPayload: Codable, Sendable {
        let phone_id: Int
        let new_number: String
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return (
            lhs.phoneId == rhs.phoneId
            && lhs.confirmed == rhs.confirmed
            && lhs.confirmationRequired == rhs.confirmationRequired
        )
    }

}
