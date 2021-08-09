//
//  Human.swift
//  
//
//  Created by Kayla Hoyet on 7/14/21.
//

import Foundation

public struct Human: Codable {
    
    internal static let path = "/human"
    
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
    
    public static func create(
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
        Request.make(
            path: self.path,
            payload: CreatePayload(firstName: firstName,
                    lastName: lastName, emailAddress: emailAddress,
                    phone: phone, secret: secret, existingPhone: existingPhone,
                    verifyPhone: verifyPhone, creationNote: creationNote,
                    supplier: supplier, hasAgentSecret: hasAgentSecret),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let firstName: String
        let lastName: String
        let emailAddress: String
        let phone: String
        let secret: String?
        let existingPhone: PhoneNumber?
        let verifyPhone: Bool?
        let creationNote: String?
        let supplier: Bool?
        let hasAgentSecret: Bool?
        
        private enum CodingKeys: String, CodingKey{
            case firstName = "first_name"
            case lastName = "last_name"
            case emailAddress = "email_address"
            case phone
            case secret
            case existingPhone = "phone_id"
            case verifyPhone = "verify_phone"
            case creationNote = "creation_note"
            case supplier
            case hasAgentSecret = "has_agent_secret"
        }
    }
    
    public static func retrieve(
        humanId: String,
        session: Session?,
        callback: @escaping (Error?, Human?) -> Void
    ) {
        fatalError("Not implemented")
    }
}



