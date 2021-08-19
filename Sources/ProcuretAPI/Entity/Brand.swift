//
//  Brand.swift
//  
//
//  Created by Kayla Hoyet on 7/23/21.
//

import Foundation

public struct Brand: Codable {
    
    internal static let path = "/entity/brand"
    
    let entityId: String
    let name: String
    let saleMessage: String
    let created: String

    
    public enum CodingKeys: String, CodingKey {
        case entityId = "entity_id"
        case name = "brand_name"
        case saleMessage = "sale_message"
        case created
    }
    
    public static func create(
        name: String,
        saleMessage: String,
        entityId: String,
        session: Session?,
        callback: @escaping (Error?, Brand?) -> Void
    ) {
        fatalError("Not implemented")
    }
}
