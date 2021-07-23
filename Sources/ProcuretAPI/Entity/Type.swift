//
//  Type.swift
//  
//
//  Created by Kayla Hoyet on 7/23/21.
//

import Foundation

public struct EntityType: Codable {
    
    let typeName: String
    let incorporated: Bool
    
    public enum CodingKeys: String, CodingKey {
        case typeName = "type_name"
        case incorporated
    }
}
