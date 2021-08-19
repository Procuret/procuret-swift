//
//  SigninToken.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct SigninToken: Codable {
    
    internal static let path = "/signin-token"
    
    let emailAddress: String
    let afterSigninPath: String?
    let perspective: Perspective //needs enumeration
    
    public enum CodingKeys: String, CodingKey {
        case emailAddress = "email_address"
        case afterSigninPath = "after_signin_path"
        case perspective
    }
    
    public static func create(
        emailAddress: String,
        afterSigninPath: String?,
        perspective: Perspective,
        callback: @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(emailAddress: emailAddress,
                afterSigninPath: afterSigninPath,
                perspective: perspective),
            session: nil,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }

    private struct CreatePayload: Codable {
        let emailAddress: String
        let afterSigninPath: String?
        let perspective: Perspective
            
        private enum CodingKeys: String, CodingKey {
            case emailAddress = "account_email"
            case afterSigninPath = "after_signin_path"
            case perspective
        }
    }
}




