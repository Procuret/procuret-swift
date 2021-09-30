//
//  Human.swift
//  
//
//  Created by Kayla Hoyet on 7/14/21.
//

import Foundation

public struct Human: Codable {
    
    internal static let path = "/human"
    
    let humanId: Int
    let firstName: String
    let lastName: String
    let resetKey: String?
    let identity: HumanIdentity?
    let created: String
    let disposition: Disposition
    let documents: Array<HumanIdentityDocument>?
    
    private enum CodingKeys: String, CodingKey {
        case humanId = "public_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case resetKey = "reset_key"
        case identity
        case created
        case disposition
        case documents
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
            payload: CreatePayload(
                firstName: firstName,
                lastName: lastName,
                emailAddress: emailAddress,
                phone: phone,
                secret: secret,
                existingPhone: existingPhone,
                verifyPhone: verifyPhone,
                creationNote: creationNote,
                supplier: supplier,
                hasAgentSecret: hasAgentSecret),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        humanId: Int,
        session: Session?,
        callback: @escaping (Error?, Human?) -> Void
    ) {
        Request.make(
            path: self.path,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [UrlParameter(humanId, key: "human_id")]
            ),
            method: .GET
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
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
}
