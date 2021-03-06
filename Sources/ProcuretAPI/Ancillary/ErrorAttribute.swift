//
//  ErrorAttribute.swift
//  
//
//  Created by Kayla Hoyet on 10/26/21.
//

import Foundation

public struct ErrorAttribute: Codable {
    
    let name: String
    let body: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "attribute_name"
        case body
    }
    
}
