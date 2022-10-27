//
//  Region.swift
//  
//
//  Created by Hugh Jeremy on 11/6/21.
//

import Foundation


public struct Region: Codable {
    
    public enum AustralianRegionId: Int {
        case NSW = 1
        case VIC = 2
        case QLD = 3
        case SA = 4
        case WA = 5
        case TAS = 6
        case NT = 7
        case ACT = 8
    }
    
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

