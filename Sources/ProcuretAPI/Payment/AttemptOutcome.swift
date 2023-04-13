//
//  AttemptOutcome.swift
//  
//
//  Created by Kayla Hoyet on 4/13/23.
//

import Foundation

public struct AttemptOutcome: Codable {
    
    public let record: Record
    
    public enum CodingKeys: String, CodingKey {
        case record 
    }
}
