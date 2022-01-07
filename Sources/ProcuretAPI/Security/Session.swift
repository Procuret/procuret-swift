//
//  File.swift
//
//
//  Created by Hugh Jeremy on 9/6/21.
//

import Foundation


public struct Session: Codable {
    
    private static let path = "/session"
    
    public let sessionId: Int
    public let sessionKey: String
    public let apiKey: String

    private enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
        case sessionKey = "session_key"
        case apiKey = "api_key"
    }
    
    public static func create(
        secret: String,
        email: String,
        code: String?,
        callback: @escaping (Error?, Session?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                secret: secret,
                email: email,
                code: code
            ),
            session: nil,
            query: nil,
            method: .POST
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    public static func fromEnvironmentVariables(
        keyVariableName: String = "PROCURET_SESSION_KEY",
        apiKeyVariableName: String = "PROCURET_API_KEY",
        idVariableName: String = "PROCURET_SESSION_ID"
    ) throws -> Session {
        
        guard let eApiKey = getenv(apiKeyVariableName) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        
        guard let apiKey = String(utf8String: eApiKey) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        
        guard let eSessionId = getenv(idVariableName) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        
        guard let stringSessionId = String(utf8String: eSessionId) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        
        guard let sessionId = Int(stringSessionId) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        
        guard let eKey = getenv(keyVariableName) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        
        guard let key = String(utf8String: eKey) else {
            throw ProcuretAPIError(.badConfiguration)
        }

        return Self(
            sessionId: sessionId,
            sessionKey: key,
            apiKey: apiKey
        )

    }
    
    private struct CreatePayload: Codable {
        let secret: String
        let email: String
        let code: String?
        
        private enum CodingKeys: String, CodingKey {
            case secret
            case email
            case code
        }
    }
}
