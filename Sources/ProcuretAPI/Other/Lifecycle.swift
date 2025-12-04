//
//  Lifecycle.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct Lifecycle: Codable, Sendable {
    
    let indexid: Int
    let name: String
    
    public enum CodingKeys: String, CodingKey {
        case indexid
        case name
    }
}
