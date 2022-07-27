//
//  Region.swift
//  
//
//  Created by Hugh Jeremy on 11/6/21.
//

import Foundation


public struct Region: Codable {
    
    public let indexId: Int
    public let name: String
    public let abbreviation: String
    public let countryId: Int
    
    private enum CodingKeys: String, CodingKey {
        case indexId = "indexid"
        case name
        case abbreviation = "abbreviation"
        case countryId = "country_id"
    }

}
