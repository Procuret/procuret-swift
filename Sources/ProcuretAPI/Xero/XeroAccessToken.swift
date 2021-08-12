//
//  XeroAccessToken.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct XeroAccessToken: Codable {
    
    internal static let path = "/xero/access-token"
    
    let publicId: String
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
    }
    
    public static func create(
        authorisationRequestId: String,
        code: String,
        session: Session?,
        callback: @escaping (Error?, XeroAccessToken?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(authorisationRequestId: authorisationRequestId,
                code: code),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
                fatalError("Not implemented")
        }
    }
                
    private struct CreatePayload: Codable {
        let authorisationRequestId: String
        let code: String
                    
        private enum CodingKeys: String, CodingKey {
            case authorisationRequestId = "authorisation_request_id"
            case code
        }
    }
}
