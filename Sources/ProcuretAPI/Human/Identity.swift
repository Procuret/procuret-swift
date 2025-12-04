//
//  HumanIdentity.swift
//  
//
//  Created by Kayla Hoyet on 7/14/21.
//

import Foundation

public struct HumanIdentity: Codable, Equatable, Sendable {
    
    internal static let path = "/human/identity"
    
    public let dateOfBirth: String?
    public let address: Address?
    
    private enum CodingKeys: String, CodingKey {
        case dateOfBirth = "date_of_birth"
        case address
    }
    
    
    /// Creates a `HumanIdentity`
    ///
    /// Note that it is the responsibility of the call site to provide a date
    /// of birth as a string. The callsite is given this responsibility because Swift lacks a "date-sans-time"
    /// type, and it would be unclear whether a provided `Date` is providing the date of birth in UTC
    /// time or system time zone. The `dateOfBirth` parameter should be a string in the form
    /// `YYYY-MM-DD`, for example, `"2022-07-01"` for the first of July, 2022.
    public static func create(
        authenticatedBy session: SessionRepresentative,
        forHuman human: Human,
        dateOfBirth: String,
        address: Address.CreationData,
        at endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                humanId: human.agentId,
                dateOfBirth: dateOfBirth,
                address: address
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    private struct CreatePayload: Codable, Sendable {
        let humanId: Int
        let dateOfBirth: String
        let address: Address.CreationData
        
        private enum CodingKeys: String, CodingKey {
            case humanId = "human_id"
            case dateOfBirth = "date_of_birth"
            case address
        }
    }
}
