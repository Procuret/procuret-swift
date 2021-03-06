//
//  Human.swift
//  
//
//  Created by Kayla Hoyet on 7/14/21.
//  Modified by Hugh Jeremy on 25 Mar 2022
//

import Foundation

public struct Human: Codable, Agent {
    
    public static let maxNameLength: Int = 64
    public static let minNameLength: Int = 1

    internal static let path = "/human"
    
    public let humanId: Int
    public let firstName: String
    public let lastName: String
    let identity: HumanIdentity?
    let created: String
    let disposition: Disposition
    let documents: Array<HumanIdentityDocument>?
    
    public var agentId: Int { get { return self.humanId } }

    private enum CodingKeys: String, CodingKey {
        case humanId = "public_id"
        case firstName = "first_name"
        case lastName = "last_name"
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
        secret: String? = nil,
        existingPhone: PhoneNumber? = nil,
        verifyPhone: Bool? = nil,
        creationNote: String? = nil,
        session: Session? = nil,
        hasAgentSecret: Bool? = nil,
        signupPerspective: Perspective = .business,
        callback: @escaping (Error?, Human?) -> Void
    ) -> Void {
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
                hasAgentSecret: hasAgentSecret,
                signupPerspective: signupPerspective
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    public static func retrieve(
        humanId: Int,
        session: Session?,
        callback: @escaping (Error?, Human?) -> Void
    ) -> Void {
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
        let hasAgentSecret: Bool?
        let signupPerspective: Perspective
        
        private enum CodingKeys: String, CodingKey{
            case firstName = "first_name"
            case lastName = "last_name"
            case emailAddress = "email_address"
            case phone = "phone_number"
            case secret
            case existingPhone = "phone_id"
            case verifyPhone = "verify_phone"
            case creationNote = "creation_note"
            case hasAgentSecret = "has_agent_secret"
            case signupPerspective = "signup_perspective"
        }
    }
}
