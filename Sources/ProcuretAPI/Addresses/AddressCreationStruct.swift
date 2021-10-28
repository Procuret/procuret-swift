//
//  AddressCreationStruct.swift
//  
//
//  Created by Kayla Hoyet on 10/28/21.
//

import Foundation

public struct AddressCreationStruct: Codable {
    let line1: String
    let line2: String?
    let line3: String?
    let line4: String?
    let postalCode: String
    let locality: String
    let regionId: Int
    let countryId: Int
    
    private enum CodingKeys: String, CodingKey {
        case line1 = "line_1"
        case line2 = "line_2"
        case line3 = "line_3"
        case line4 = "line_4"
        case postalCode = "postal_code"
        case locality
        case regionId = "region"
        case countryId = "country"
    }
}
