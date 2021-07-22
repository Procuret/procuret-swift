//
//  Human.swift
//  
//
//  Created by Kayla Hoyet on 7/14/21.
//

import Foundation

public struct Human: Codable {
    
    let humanId: String
    let emailAddress: String
    let phoneNumber: String
    let firstName: String
    let lastName: String
    let resetKey: String?
    
    private enum CodingKeys: String, CodingKey {
        case humanId
        case emailAddress = "email_address"
        case phoneNumber = "phone_number"
        case firstName = "first_name"
        case lastName = "last_name"
        case resetKey = "reset_key"
    }
    
    var fullName: String {
        return self.firstName + " " + self.lastName
    }
    
    public static func create (
        firstName: String,
        lastName: String,
        emailAddress: String,
        phone: String,
        secret: String?,
        existingPhone: PhoneNumber?,
        verifyPhone: Bool?,
        creationNote: String?,
        session: Session?,
        supplier: Bool?,
        hasAgentSecret: Bool?,
        callback: @escaping (Error?, Human?) -> Void
        ) {
            fatalError("Not implemented")
        }
}

