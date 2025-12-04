//
//  File.swift
//  
//
//  Created by Hugh on 3/5/2023.
//

import Foundation

public struct PhoneChallenge: Sendable {
    
    private static let path = "/phone-number/challenge"
    
    public static func create(
        authenticatedBy session: SessionRepresentative,
        for number: PhoneNumber,
        at endpoint: ApiEndpoint = .live,
        then callback: @Sendable @escaping (Error?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(
                [UrlParameter(number.phoneId, key: "phone_id")]
            ),
            method: .POST,
            endpoint: endpoint
        ) { error, _ in callback(error); return }
        
        return

    }
    
}

