//
//  PhoneNumber.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//

import Foundation

public struct PhoneNumber: Codable {
    
    let phoneId: Int
    let digits: String
    
    private enum CodingKeys: String, CodingKey {
        case phoneId = "index_id"
        case digits
    }
    
    public static func create (
        digits: String,
        session: Session?,
        callback: @escaping (Error?, PhoneNumber?) -> Void
        ) {
            fatalError("Not implemented")
        }
}
