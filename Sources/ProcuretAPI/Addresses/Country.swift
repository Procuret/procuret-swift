//
//  Country.swift
//  
//
//  Created by Kayla Hoyet on 7/5/21
//

import Foundation


public struct Country: Codable {
    
    let countryId: Int
    let name: String
    let iso3166a2: String
    let iso3166a3: String
    
    private enum CodingKeys: String, CodingKey {
        case countryId = "country_id"
        case name
        case iso3166a2 = "iso_3166_a2"
        case iso3166a3 = "iso_3166_a3"
    }

}
