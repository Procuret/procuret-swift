//
//  Payment.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct Payment: Codable, Equatable, Sendable {
    
    let publicId: String
    let created: Date
    let executed: Date
    let active: Bool
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case created
        case executed
        case active
    }
    
}
