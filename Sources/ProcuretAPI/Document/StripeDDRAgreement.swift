//
//  StripeDDRAgreement.swift
//  
//
//  Created by Kayla Hoyet on 11/17/21.
//

import Foundation

public struct StripeDDRAgreement: Document {
    
    public static let path = "/document/stripe-ddr"
    
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
