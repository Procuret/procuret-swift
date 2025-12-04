//
//  PaymentMethodKernel.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//  Modified by Hugh Jeremy 27 Mar 2022
//

import Foundation

public struct PaymentMethodKernel: Codable, Sendable {
    
    let publicId: String
    let entityId: Int?
    let created: Date
    let creatingAgentId: Int
    let authorityAgentId: Int
    let custodian: Custodian
    let instrument: Instrument
    let disposition: Disposition
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case entityId = "entity_id"
        case created
        case creatingAgentId = "creating_agent_id"
        case authorityAgentId = "authority_agent_id"
        case custodian
        case instrument
        case disposition
    }
    
}
