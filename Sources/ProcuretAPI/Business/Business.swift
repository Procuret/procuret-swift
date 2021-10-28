//
//  Business.swift
//  
//
//  Created by Kayla Hoyet on 10/28/21.
//

import Foundation

public struct Business: Codable {
    
    internal static let path = "/business"
    
    let entity: Entity //need to confirm type
    
    private enum CodingKeys: String, CodingKey {
        case entity
    }
    
    public static func create(
        abn: String,
        address: Address, //may change to AddressCreationStruct
        session: Session?,
        callback: @escaping (Error?, Business?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                abn: abn,
                address: address
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
        let abn: String
        let address: Address
        
        private enum CodingKeys: String, CodingKey {
            case abn
            case address
        }
    }

}
