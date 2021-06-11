//
//  Region.swift
//  
//
//  Created by Hugh Jeremy on 11/6/21.
//

import Foundation


public struct Region: Codable {
    
    let id: Int
    let name: String
    let abbreviation: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "region_id"
        case name = "name"
        case abbreviation = "abbreviation"
    }

}
