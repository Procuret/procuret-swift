//
//  File.swift
//
//
//  Created by Hugh Jeremy on 9/6/21.
//

import Foundation


public struct Session: Codable, Agent, SessionRepresentative {
    
    private static let path = "/session"
    
    public static let defaultKeyEnvName = "PROCURET_SESSION_KEY"
    public static let defaultApiKeyEnvName = "PROCURET_API_KEY"
    public static let defaultIdEnvName = "PROCURET_SESSION_ID"
    public static let defaultPerspectiveEnvName = "PROCURET_PERSPECTIVE"
    public static let defaultAgentEnvName = "PROCURET_AGENT_ID"
    
    public let sessionId: Int
    public let sessionKey: String
    public let apiKey: String
    public let perspective: Perspective
    
    private let genericAgent: GenericAgent
    
    public var agent: StandaloneAgent { get {
        switch self.genericAgent {
        case .human(let human):
            return human.asStandaloneAgent
        case .standaloneAgent(let agent):
            return agent
        }
    } }
    
    public var human: Human? { get {
        switch self.genericAgent {
        case .human(let human):
            return human
        case .standaloneAgent:
            return nil
        }
    } }
    
    public var agentId: Int { get { return self.agent.agentId } }

    private enum CodingKeys: String, CodingKey {
        case sessionId = "session_id"
        case sessionKey = "session_key"
        case apiKey = "api_key"
        case perspective
        case genericAgent = "agent"
    }
    
    public init(
        sessionId: Int,
        sessionKey: String,
        apiKey: String,
        perspective: Perspective,
        genericAgent: GenericAgent
    ) {

        self.sessionId = sessionId
        self.sessionKey = sessionKey
        self.apiKey = apiKey
        self.perspective = perspective
        self.genericAgent = genericAgent
        
        return
    }
    
    public init(
        sessionId: Int,
        sessionKey: String,
        apiKey: String,
        perspective: Perspective,
        agent: StandaloneAgent
    ) {

        self.sessionId = sessionId
        self.sessionKey = sessionKey
        self.apiKey = apiKey
        self.perspective = perspective
        self.genericAgent = GenericAgent(agent)
        
        return
    }

    public static func create(
        secret: String,
        email: String,
        code: String,
        perspective: Perspective,
        endpoint: ApiEndpoint = ApiEndpoint.live,
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
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }

    public static func retrieve(
        sessionId: Int,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Session?) -> Void
    ) -> Void {

        Request.make(
            path: self.path,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [UrlParameter(sessionId, key: "session_id")]
            ),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
        
        return
        
    }
    
    public func refresh(
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Session?) -> Void
    ) -> Void {
        
        Self.retrieve(
            sessionId: self.sessionId,
            session: self,
            endpoint: endpoint,
            callback: callback
        )

        return

    }
    
    public func changePerspective(
        newPerspective: Perspective,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Session?) -> Void
    ) -> Void {
        
        struct ChangePayload: Codable {
            let perspective_id: Int
        }
        
        Request.make(
            path: Self.path,
            payload: ChangePayload(perspective_id: newPerspective.rawValue),
            session: self,
            query: nil,
            method: .PUT,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
        
        return
        
    }
    
    public static func forceFromEnvironmentVariables(
        keyVariableName: String = Self.defaultKeyEnvName,
        apiKeyVariableName: String = Self.defaultApiKeyEnvName,
        idVariableName: String = Self.defaultIdEnvName,
        perspectiveVariableName: String = Self.defaultPerspectiveEnvName,
        agentName: String = Self.defaultAgentEnvName
    ) -> Session {
        
        do {
            return try Self.fromEnvironmentVariables(
                keyVariableName: keyVariableName,
                apiKeyVariableName: apiKeyVariableName,
                idVariableName: idVariableName,
                perspectiveVariableName: perspectiveVariableName
            )
        } catch {
            fatalError("unable to force Session from environment")
        }

    }
    
    public static func optionallyFromEnvironmentVariables(
        keyVariableName: String = Self.defaultKeyEnvName,
        apiKeyVariableName: String = Self.defaultApiKeyEnvName,
        idVariableName: String = Self.defaultIdEnvName,
        perspectiveVariableName: String = Self.defaultPerspectiveEnvName,
        agentName: String = Self.defaultAgentEnvName
    ) throws -> Session? {
        
        guard let _ = getenv(keyVariableName)         else { return nil }
        guard let _ = getenv(apiKeyVariableName)      else { return nil }
        guard let _ = getenv(idVariableName)          else { return nil }
        guard let _ = getenv(perspectiveVariableName) else { return nil }
        guard let _ = getenv(agentName)               else { return nil }
        
        return try Self.fromEnvironmentVariables(
            keyVariableName: keyVariableName,
            apiKeyVariableName: apiKeyVariableName,
            idVariableName: idVariableName,
            perspectiveVariableName: perspectiveVariableName,
            agentName: agentName
        )
        
    }
    
    public static func fromEnvironmentVariables(
        keyVariableName: String = Self.defaultKeyEnvName,
        apiKeyVariableName: String = Self.defaultApiKeyEnvName,
        idVariableName: String = Self.defaultIdEnvName,
        perspectiveVariableName: String = Self.defaultPerspectiveEnvName,
        agentName: String = Self.defaultAgentEnvName
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
        
        guard let eAgent = getenv(agentName) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        
        guard let agentIdString = String(utf8String: eAgent) else {
            throw ProcuretAPIError(.badConfiguration)
        }

        guard let agentId = Int(agentIdString) else {
            throw ProcuretAPIError(.badConfiguration)
        }
        
        return Self(
            sessionId: sessionId,
            sessionKey: key,
            apiKey: apiKey,
            perspective: perspective,
            agent: StandaloneAgent(agentId: agentId)
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
