//
//  HumanIdentity.swift
//  
//
//  Created by Kayla Hoyet on 7/14/21.
//

import Foundation

public struct HumanIdentity: Codable, Equatable {
    
    internal static let path = "/human/identity"
    
    public let dateOfBirth: String?
    public let address: Address?
    
    private enum CodingKeys: String, CodingKey {
        case dateOfBirth = "date_of_birth"
        case address
    }
    
    public static func create(
        humanId: Int,
        dateOfBirth: String,
        address: Address.CreationData,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                humanId: humanId,
                dateOfBirth: dateOfBirth,
                address: address),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    private struct CreatePayload: Codable {
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
