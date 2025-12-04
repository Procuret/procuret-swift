//
//  CreditModel.swift
//  
//
//  Created by Kayla Hoyet on 8/5/21.
//

import Foundation

public struct CreditModel: Codable, Sendable {
    
    let indexid: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case indexid
        case name
    }
}
