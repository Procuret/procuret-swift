//
//  Generic.swift
//  
//
//  Created by Hugh on 23/9/2022.
//

import Foundation



public enum GenericAgent: Codable {
    
    case human(Human)
    case standaloneAgent(StandaloneAgent)
    
    private enum CodingKeys: String, CodingKey {
        case agentId = "agent_id"
        case humanFlag = "first_name"
    }
    
    public init(
        _ agent: StandaloneAgent
    ) {
        self = Self.standaloneAgent(agent)
        return
    }
    
    public init(
        _ human: Human
    ) {
        self = Self.human(human)
        return
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Self.CodingKeys.self)
        
        let humanFlag = try container.decode(
            String?.self,
            forKey: .humanFlag
        )
        
        if humanFlag != nil {
            self = Self.human(try Human.init(from: decoder))
        } else {
            self = Self.standaloneAgent(
                try StandaloneAgent.init(from: decoder)
            )
        }

    }
    
    public func encode(to encoder: Encoder) throws {
        
        switch self {
        case .human(let human):
            return try human.encode(to: encoder)
        case .standaloneAgent(let agent):
            return try agent.encode(to: encoder)
        }
        
    }
    
}
