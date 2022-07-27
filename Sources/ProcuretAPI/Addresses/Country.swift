//
//  Country.swift
//  
//
//  Created by Kayla Hoyet on 7/5/21
//

import Foundation


public struct Country: Codable {
    
    public let countryId: Int
    public let name: String
    public let iso3166a2: String
    public let iso3166a3: String
    
    private enum CodingKeys: String, CodingKey {
        case countryId = "country_id"
        case name
        case iso3166a2 = "iso_3166_a2"
        case iso3166a3 = "iso_3166_a3"
    }

}
