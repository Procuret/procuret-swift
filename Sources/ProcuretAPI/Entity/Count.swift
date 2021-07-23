//
//  Count.swift
//  
//
//  Created by Kayla Hoyet on 7/23/21.
//

import Foundation

public struct EntityCount: Codable {
    
    let count: Int
    let fragment: String
    
    public enum CodingKeys: String, CodingKey {
        case count
        case fragment
    }
}
