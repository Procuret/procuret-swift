//
//  SupplierSession.swift
//  
//
//  Created by Kayla Hoyet on 8/2/21.
//

import Foundation

public struct SupplierSession: Codable {
    
    internal static let path = "/supplier/session"
    
    let secret: String
    let email: String
    let session: Session
    
    private enum CodingKeys: String, CodingKey {
        case secret
        case email
        case session
    }
    
    public static func create(
        secret: String,
        email: String,
        session: Session?,
        callback: @escaping (Error?, Session?) -> Void
    ) {
        fatalError("Not implemented")
    }
}
