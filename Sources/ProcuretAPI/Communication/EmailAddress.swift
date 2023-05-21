//
//  EmailAddress.swift
//  
//
//  Created by Kayla Hoyet on 9/8/22.
//

import Foundation

public struct EmailAddress: Codable, Equatable {
    
    public let created: String
    public let emailAddress: String
    public let confirmationRequired: Bool
    
    public var rawEmailString: String { get {
        return self.emailAddress
    } }
    
    private enum CodingKeys: String, CodingKey {
        case created
        case emailAddress = "email_address"
        case confirmationRequired = "confirmation_required"
    }
        
}

