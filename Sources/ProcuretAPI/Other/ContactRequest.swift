//
//  ContactRequest.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct ContactRequest: Codable, Sendable {
    
    internal static let path = "/contact-request"
    
    let emailAddress: String
    let phoneNumber: String
    let firstName: String
    let lastName: String
    let message: String
    
    public enum CodingKeys: String, CodingKey {
        case emailAddress = "email_address"
        case phoneNumber = "phone_number"
        case firstName = "first_name"
        case lastName = "last_name"
        case message
    }
    
    public static func create (
        emailAddress: String,
        phoneNumber: String,
        firstName: String,
        lastName: String,
        message: String,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(emailAddress: emailAddress,
                phoneNumber: phoneNumber, firstName: firstName,
                lastName: lastName, message: message),
            session: nil,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable, Sendable {
        let emailAddress: String
        let phoneNumber: String
        let firstName: String
        let lastName: String
        let message: String
        
        private enum CodingKeys: String, CodingKey {
            case emailAddress = "email"
            case phoneNumber = "phone"
            case firstName = "first_name"
            case lastName = "last_name"
            case message
        }
    }
}
