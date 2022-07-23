//
//  AddressCreationStruct.swift
//  
//
//  Created by Kayla Hoyet on 10/28/21.
//

import Foundation

public struct AddressCreationStruct: Codable {
    public let line1: String
    public let line2: String?
    public let line3: String?
    public let line4: String?
    public let postalCode: String
    public let locality: String
    public let regionId: Int
    public let countryId: Int
    
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
