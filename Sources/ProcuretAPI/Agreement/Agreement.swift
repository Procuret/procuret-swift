//
//  File.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct Agreement: Codable {
    
    let publicId: String
    let setupId: String
    let partyEntityId: Int?
    let assentType: String
    let contractId: String
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case setupId = "setup_id"
        case partyEntityId = "party_entity_id"
        case assentType = "assent_type"
        case contractId = "contract_id"
    }
}
