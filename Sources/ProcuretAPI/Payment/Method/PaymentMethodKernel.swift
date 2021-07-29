//
//  PaymentMethodKernel.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct PaymentMethodKernel: Codable {
    
    let publicId: String
    let entityId: Int
    let created: ProcuretTime
    let creatingAgentId: Int
    let authorityAgentId: Int
    let processor: Int?
    let disposition: Disposition
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case entityId = "entity_id"
        case created
        case creatingAgentId = "creating_agent_id"
        case authorityAgentId = "authority_agent_id"
        case processor
        case disposition
    }
    
}
