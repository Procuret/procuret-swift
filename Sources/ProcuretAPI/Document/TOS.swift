//
//  TOS.swift
//  
//
//  Created by Kayla Hoyet on 8/6/21.
//

import Foundation

public struct TOS:  Document {
    
    public static let path = "/document/terms-of-service"
    
    public let created: Date
    public let body: String
    public let asHtml: Bool
    public let name: String
    
    private enum CodingKeys: String, CodingKey {
        case created
        case body
        case asHtml = "as_html"
        case name
    }
}
