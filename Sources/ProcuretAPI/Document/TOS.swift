//
//  TOS.swift
//  
//
//  Created by Kayla Hoyet on 8/6/21.
//

import Foundation

public struct TOS: Codable {
    
    internal static let path = "/document/terms-of-service"
    internal static let name = "Terms of Service"
    
    public static func create(
        markdownBody: String,
        callback: @escaping (Error, DocumentRevision) -> Void
    ) {
        fatalError("Not implemented")
    }
}
