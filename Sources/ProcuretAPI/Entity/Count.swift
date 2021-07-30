//
//  Count.swift
//  
//
//  Created by Kayla Hoyet on 7/23/21.
//

import Foundation

public struct EntityCount: Codable {
    
    internal static let path = "entity/count"
    
    let count: Int
    let fragment: String
    
    public enum CodingKeys: String, CodingKey {
        case count
        case fragment
    }
    
    public static func retrieve (
        nameFragment: String?,
        callback: @escaping (Error?, EntityCount?) -> Void
        ) {
        fatalError("Not implemented")
        }
}
