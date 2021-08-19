//
//  Headline.swift
//  
//
//  Created by Kayla Hoyet on 7/22/21.
//

import Foundation

public struct HumanHeadline: Codable {
    
    let agentId: Int
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case agentId = "agent_id"
        case fullName = "full_name"
    }
}
