//
//  XeroBrandingTheme.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct XeroBrandingTheme: Codable {
    
    internal static let path = "/xero/branding-theme"
    
    let themeId: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case themeId = "theme_id"
        case name
    }
}
