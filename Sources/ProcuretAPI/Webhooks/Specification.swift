//
//  Specification.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct Specification: Codable {
    
    internal static let path = "/webhook/specification"
    internal static let testPath = "/webhook/specification/test"
    
    public static func create(
        entityId: Int,
        destination: String,
        secret: String,
        formatId: Int,
        eventIds: Array<Int>,
        callback: @escaping (Error?) -> Void
    ) {
        fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let entityId: Int
        let destination: String
        let secret: String
        let formatId: Int
        let eventIds: Array<Int>
        
        private enum CodingKeys: String, CodingKey {
            case entityId = "entity_id"
            case destination
            case secret
            case formatId = "format_id"
            case eventIds = "event_ids"
    }
}

