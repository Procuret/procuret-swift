//
//  ProspectiveDivision.swift
//  
//
//  Created by Kayla Hoyet on 4/28/23.
//

import Foundation

public struct ProspectiveDivision: Codable, Identifiable {
    
    public let methodId: String
    public let magnitude: String
    
    public var id: String { get { return self.methodId; } }
    
    public enum CodingKeys: String, CodingKey {
        case methodId = "method_id"
        case magnitude
    }
}

public struct GenericProspectiveDivision: Codable {
    
    let methodId: String
    
    public enum CodingKeys: String, CodingKey {
      case methodId = "method_id"
        
    }
}
