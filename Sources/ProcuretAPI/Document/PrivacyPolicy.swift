//
//  PrivacyPolicy.swift
//  
//
//  Created by Kayla Hoyet on 8/5/21.
//

import Foundation

public struct PrivacyPolicy: Document {

    public static let path = "/document/privacy-policy"
    
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
