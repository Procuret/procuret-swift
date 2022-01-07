//
//  SecondFactorCode.swift
//  
//
//  Created by Kayla Hoyet on 10/11/21.
//

import Foundation

public struct SecondFactorCode: Codable {
    
    private static let path = "/second-factor-code"
    
    private static func create(
        email: String?,
        agentId: String?,
        secret: String,
        perspective: Perspective?,
        callback: @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                email: email,
                agentId: agentId,
                secret: secret,
                perspective: perspective
            ),
            session: nil,
            query: nil,
            method: .POST
        ) { error, _ in
            callback(error)
        }
    }
    
    public static func create(
        email: String,
        secret: String,
        perspective: Perspective?,
        callback: @escaping (Error?) -> Void
    ) {
        return Self.create(
            email: email,
            agentId: nil,
            secret: secret,
            perspective: perspective,
            callback: callback
        )
    }
    
    public static func create(
        agentId: String,
        secret: String,
        perspective: Perspective?,
        callback: @escaping (Error?) -> Void
    ) {
        return Self.create(
            email: nil,
            agentId: agentId,
            secret: secret,
            perspective: perspective,
            callback: callback
        )
    }
    
    private struct CreatePayload: Codable {
        let email: String?
        let agentId: String?
        let secret: String
        let perspective: Perspective?
        
        private enum CodingKeys: String, CodingKey {
            case email
            case agentId = "agent_id"
            case secret = "plaintext_secret"
            case perspective
        }
    }
    
    public static func fromEnvironmentVariables(
        secretVariableName: String = "PLAINTEXT_SECRET"
    ) throws -> String {
        
        guard let eSecret = getenv(secretVariableName) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        
        guard let secret = String(utf8String: eSecret) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        
        return secret
    }
}
