//
//  Address.swift
//
//
//  Created by Kayla Hoyet on 7/6/21.
//

import Foundation

public struct Address: Codable, Equatable, Identifiable {
    
    public let publicId: String
    public let line1: String
    public let line2: String?
    public let line3: String?
    public let line4: String?
    public let locality: String?
    public let postalCode: String?
    public let region: Region?
    public let country: Country?
    
    public var id: String { get { return self.publicId } }

    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
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
            line += region?.abbreviation ?? ""
            line += self.postalCode ?? ""
            line += country?.iso3166a3 ?? ""
            return line
        }
    }
    
    var oneLineSansCountry: String {
        get {
            var line = self.line1
            if let line2 = self.line2 {line += ", " + line2}
            if let line3 = self.line3 {line += ", " + line3}
            if let line4 = self.line4 {line += ", " + line4}
            line += self.locality ?? ""
            line += region?.abbreviation ?? ""
            line += self.postalCode ?? ""
            return line
            
        }
    }
    
    public struct CreationData: Codable {
        
        public let line1: String
        public let line2, line3, line4: String?
        public let postalCode: String
        public let locality: String
        public let regionId: Int
        public let countryId: Int
        
        public init(
            line1: String,
            line2: String?,
            line3: String?,
            line4: String?,
            postalCode: String,
            locality: String,
            regionId: Int,
            countryId: Int
        ) {
            self.line1 = line1
            self.line2 = line2
            self.line3 = line3
            self.line4 = line4
            self.postalCode = postalCode
            self.locality = locality
            self.regionId = regionId
            self.countryId = countryId
                
            return
        }
        
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
}
