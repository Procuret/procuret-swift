//
//  Identifier.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//

import Foundation

public struct EntityIdentifier: Codable {
    
    public static let path = "/"
    
    let idType: String
    let idString: String
    
    public enum CodingKeys: String, CodingKey {
        case idType = "id_type"
        case idString = "id"
    }
    
    public static func create (
        EntityId: Int,
        idType: Int,
        identifier: String,
        callback: @escaping (Error?, Data?) -> Void
        ) {
        fatalError("Not implemented")
    }
}
