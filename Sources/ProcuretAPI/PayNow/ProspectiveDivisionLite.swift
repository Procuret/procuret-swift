//
//  ProspectiveDivisionLite.swift
//  
//
//  Created by Kayla Hoyet on 4/28/23.
//

import Foundation

public struct ProspectiveDivisionLite: Codable {
    
    public let instrument: Instrument
    public let magnitude: String
    
    public enum CodingKeys: String, CodingKey {
        case instrument
        case magnitude 
    }
}
