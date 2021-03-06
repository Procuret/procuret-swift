//
//  DocumentRevision.swift
//  
//
//  Created by Kayla Hoyet on 7/27/21.
//

import Foundation

public struct DocumentRevision: Codable {
    
    let created: Date
    let body: String
    let asHTML: Bool
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case created
        case body
        case asHTML = "as_html"
        case name
    }
}
