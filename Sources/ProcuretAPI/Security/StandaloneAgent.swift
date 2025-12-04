//
//  StandaloneAgent.swift
//  
//
//  Created by Hugh Jeremy on 25/3/2022.
//

import Foundation


public struct StandaloneAgent: Agent, Codable, Equatable, Sendable {
    
    public let agentId: Int
    
    public init(agentId: Int) {
        self.agentId = agentId
        return
    }

    private enum CodingKeys: String, CodingKey {
        case agentId = "agent_id"
    }

}
