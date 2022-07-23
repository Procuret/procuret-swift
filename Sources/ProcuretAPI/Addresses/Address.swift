//
//  Address.swift
//
//
//  Created by Kayla Hoyet on 7/6/21.
//

import Foundation

public struct Address: Codable {
    public let line1: String
    public let line2: String?
    public let line3: String?
    public let line4: String?
    public let locality: String
    public let postalCode: String
    public let region: Region
    public let country: Country
    
    private enum CodingKeys: String, CodingKey {
        case line1 = "line_1"
        case line2 = "line_2"
        case line3 = "line_3"
        case line4 = "line_4"
        case locality
        case postalCode = "postal_code"
        case region
        case country
    }
    
    var oneLine: String {
        get {
            var line = self.line1
            if let line2 = self.line2 {line += ", " + line2}
            if let line3 = self.line3 {line += ", " + line3}
            if let line4 = self.line4 {line += ", " + line4}
            line += region.abbreviation
            line += self.postalCode
            line += country.iso3166a3
            return line
        }
    }
    
    var oneLineSansCountry: String {
        get {
            var line = self.line1
            if let line2 = self.line2 {line += ", " + line2}
            if let line3 = self.line3 {line += ", " + line3}
            if let line4 = self.line4 {line += ", " + line4}
            line += self.locality
            line += region.abbreviation
            line += self.postalCode
            return line
            
        }
    }
}

