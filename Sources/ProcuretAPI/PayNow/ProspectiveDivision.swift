//
//  ProspectiveDivision.swift
//  
//
//  Created by Kayla Hoyet on 4/28/23.
//

import Foundation

public struct ProspectiveDivision: Codable, Sendable {
    
    public let methodId: String
    public let magnitude: String
    
    public enum CodingKeys: String, CodingKey {
        case methodId = "method_id"
        case magnitude
    }
}
