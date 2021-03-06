//
//  PhoneNumber.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//

import Foundation

public struct PhoneNumber: Codable {
    
    internal static let path = "/phone-number"
    
    public let phoneId: Int
    public let digits: String
    
    private enum CodingKeys: String, CodingKey {
        case phoneId = "indexid"
        case digits
    }
    
    public static func create (
        digits: String,
        session: Session?,
        callback: @escaping (Error?, PhoneNumber?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(digits: digits),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let digits: String
        
        private enum CodingKeys: String, CodingKey {
            case digits = "phone"
        }
    }
}
