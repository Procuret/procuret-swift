//
//  Privilege.swift
//
//
//  Created by Kayla Hoyet on 8/6/21.
//
import Foundation

public struct Privilege: Codable, Sendable {
    
    let indexid: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case indexid
        case name
    }
}
