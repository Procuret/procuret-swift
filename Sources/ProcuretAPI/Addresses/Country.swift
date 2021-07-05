//
//  Country.swift
//  
//
//  Created by Kayla Hoyet on 7/5/21
//

import Foundation


public struct Country: Codable {
    
    let id: Int
    let name: String
    let abbreviation: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "country_id"
        case name = "name"
        case abbreviation = "abbreviation"
    }

}
