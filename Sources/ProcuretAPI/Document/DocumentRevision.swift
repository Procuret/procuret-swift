//
//  Document.swift
//  
//
//  Created by Kayla Hoyet on 7/27/21.
//

import Foundation

public struct Document: Codable {
    
    let name: String
    let created: String
    let markdownBody: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case created
        case markdownBody = "markdown_body"
    }
    
    public static func create (
        markdownBody: String,
        path: String,
        name: String,
        callback: @escaping (Error?, Document?) -> Void
        ) {
        fatalError("Not implemented")
    }
}
