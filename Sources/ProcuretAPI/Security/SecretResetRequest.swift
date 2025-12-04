//
//  File.swift
//  
//
//  Created by Hugh on 18/7/2022.
//

import Foundation


public struct SecretResetRequest: Sendable {
    
    internal static let path = "/human/secret/reset-request"
    
    public static func create(
        email: String,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            payload: CreatePayload(account_email: email),
            session: nil,
            query: nil,
            method: .POST,
            endpoint: endpoint,
            then: { error, _ in callback(error); return }
        )
        
        return
        
    }
    
    private struct CreatePayload: Encodable {
        let account_email: String
    }
    
}
