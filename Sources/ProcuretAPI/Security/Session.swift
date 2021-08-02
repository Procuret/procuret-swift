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
    
}
