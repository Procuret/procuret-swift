//
//  Document.swift
//  
//
//  Created by Kayla Hoyet on 7/27/21.
//

import Foundation

public struct DocumentRevision: Codable {
    
    let name: String
    let created: String
    let markdownBody: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case created
        case markdownBody = "markdown_body"
    }
    
    public static func create(
        markdownBody: String,
        path: String,
        name: String,
        callback: @escaping (Error?, DocumentRevision?) -> Void
    ) {
        Request.make(
            path: path,
            payload: CreatePayload(
                markdownBody: markdownBody,
                path: path,
                name: name
            ),
            session: nil,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let markdownBody: String
        let path: String
        let name: String
        
        private enum CodingKeys: String, CodingKey {
            case markdownBody = "markdown_body"
            case path
            case name
        }
    }
}
