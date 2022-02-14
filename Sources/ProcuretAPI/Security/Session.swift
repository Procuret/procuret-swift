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
    public let perspective: Perspective

    private enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
        case sessionKey = "session_key"
        case apiKey = "api_key"
        case perspective
    }
    
    public static func create(
        secret: String,
        email: String,
        code: String,
        perspective: Perspective,
        callback: @escaping (Error?, Session?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                secret: secret,
                email: email,
                code: code,
                perspective: perspective
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
        idVariableName: String = "PROCURET_SESSION_ID",
        perspectiveVariableName: String = "PROCURET_PERSPECTIVE"
        
    ) throws -> Session {
        
        guard let ePerspective = getenv(perspectiveVariableName) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        guard let stringPerspective = String(utf8String: ePerspective) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        guard let intPerspective = Int(stringPerspective) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        guard let perspective = Perspective(rawValue: intPerspective) else {
            throw ProcuretAPIError(.badConfiguration)
        }
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
            apiKey: apiKey,
            perspective: perspective
        )
    }
    
    private struct CreatePayload: Codable {
        let secret: String
        let email: String
        let code: String
        let perspective: Perspective
        
        private enum CodingKeys: String, CodingKey {
            case secret
            case email
            case code
            case perspective
        }
    }
}
