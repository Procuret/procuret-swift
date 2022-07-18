//
//  File.swift
//  
//
//  Created by Hugh on 18/7/2022.
//

import Foundation


struct SecretResetRequest {
    
    internal static let path = "/human/secret/reset-request"
    
    public static func create(
        email: String,
        callback: @escaping (Error?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            payload: CreatePayload(account_email: email),
            session: nil,
            query: nil,
            method: .POST,
            then: { error, _ in callback(error); return }
        )
        
        return
        
    }
    
    private struct CreatePayload: Encodable {
        let account_email: String
    }
    
}
