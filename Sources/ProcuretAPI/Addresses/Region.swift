//
//  Region.swift
//  
//
//  Created by Hugh Jeremy on 11/6/21.
//

import Foundation


public struct Region: Codable {
    
    let regionId: Int
    let name: String
    let abbreviation: String
    
    private enum CodingKeys: String, CodingKey {
        case regionId = "indexid"
        case name = "region_name"
        case abbreviation = "abbreviation"
    }

}
