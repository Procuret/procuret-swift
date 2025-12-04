//
//  Headline.swift
//  
//
//  Created by Kayla Hoyet on 7/22/21.
//

import Foundation

public struct HumanHeadline: Codable, Agent, Equatable, Sendable {
    
    public let agentId: Int
    public let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case agentId = "agent_id"
        case fullName = "full_name"
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.agentId == rhs.agentId
    }

}
