//
//  Region.swift
//  
//
//  Created by Hugh Jeremy on 11/6/21.
//

import Foundation


public struct Region: Codable {
    
    let indexId: Int
    let name: String
    let abbreviation: String
    let countryId: Int
    
    private enum CodingKeys: String, CodingKey {
        case indexId = "indexid"
        case name
        case abbreviation = "abbreviation"
        case countryId = "country_id"
    }

}
