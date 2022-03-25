//
//  StandaloneAgent.swift
//  
//
//  Created by Hugh Jeremy on 25/3/2022.
//

import Foundation


public struct StandaloneAgent: Agent, Codable {
    
    public let agentId: Int
    
    private enum CodingKeys: String, CodingKey {
        case agentId = "agent_id"
    }

}
