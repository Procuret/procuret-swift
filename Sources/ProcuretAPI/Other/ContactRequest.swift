//
//  ContactRequest.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct ContactRequest: Codable {
    
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
        callback: @escaping (Error?) -> Void
    ) {
        fatalError("Not implemented")
    }
}
