//
//  PrivacyPolicy.swift
//  
//
//  Created by Kayla Hoyet on 8/5/21.
//

import Foundation

public struct PrivacyPolicy: Codable {
    
    internal static let name = "Privacy Policy"
    internal static let path = "/document/privacy-policy"
    
    public static func create(
        markdownBody: String,
        callback: @escaping (Error, DocumentRevision) -> Void
    ) {
        fatalError("Not implemented")
    }
}
