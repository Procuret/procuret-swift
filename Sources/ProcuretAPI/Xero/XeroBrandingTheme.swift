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
    
    public static func retrieveList(
        entityId: String,
        session: Session?,
        callback: @escaping (Error?, Array<XeroBrandingTheme>?) -> Void
    ) {
        Request.make(
            path: self.path + "/list",
            payload: RetrieveListParameters(entityId: entityId),
            session: session,
            query: nil,
            method: .GET
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct RetrieveListParameters: Codable {
        let entityId: String
        
        private enum CodingKeys: String, CodingKey {
            case entityId = "entity_id"
        }
    }
}
