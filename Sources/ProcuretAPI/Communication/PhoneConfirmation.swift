//
//  PhoneConfirmation.swift
//  
//
//  Created by Kayla Hoyet on 10/6/22.
//

import Foundation

public struct PhoneConfirmation: Codable {
    
    internal static let path = "/phone-number/confirm"
    
    public static func create (
        phoneId: Int,
        code: String,
        session: Session,
        callback: @escaping (Error?) -> Void
    ) {
        Request.make(
            path: "/phone-number/confirm",
            payload: CreatePayload(
                phoneId: phoneId,
                code: code
            ),
            session: session,
            query: nil,
            method: .POST
        ) {
            error, data in
            callback(error)
            return
        }
    }
    
    private struct CreatePayload: Codable {
        let phoneId: Int
        let code: String
        
        private enum CodingKeys: String, CodingKey {
            case phoneId = "phone_id"
            case code
        }
    }
}
