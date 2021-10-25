//
//  TestEmail.swift
//  
//
//  Created by Kayla Hoyet on 10/22/21.
//

import Foundation

public struct TestEmail: Codable {
    
    static func generateEmail() -> String {
        
        let domain: String = "@procuret-test-domain.org"
        let randomNumber: Int = Int.random(in: 1000...99999)
        
        return String(randomNumber) + domain
        
    }
}
