//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 29/3/2022.
//

import Foundation


public struct BECSAccountDetails: Codable, Sendable {
    
    public let last4: String
    public let bsb: String
    public let providerId: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case last4 = "last_4"
        case bsb
        case providerId = "provider_id"
        
    }
    
}
