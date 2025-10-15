//
//  Headline.swift
//  
//
//  Created by Kayla Hoyet on 7/22/21.
//

import Foundation

public struct HumanHeadline: Codable, Agent, Equatable {
    public let agentId: Int
    public let fullName: String

    private enum CodingKeys: String, CodingKey {
        case agentId  = "agent_id"
        case fullName = "full_name"
        case name     = "name"
    }

    public init(agentId: Int, fullName: String) {
        self.agentId = agentId
        self.fullName = fullName
    }

    // Python key is full_name, nio is name
    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        self.agentId  = try c.decode(Int.self, forKey: .agentId)
        self.fullName =
            try c.decodeIfPresent(String.self, forKey: .fullName)
         ?? c.decode(String.self, forKey: .name)
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(agentId,  forKey: .agentId)
        try c.encode(fullName, forKey: .fullName)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.agentId == rhs.agentId
    }

}
