//
//  Country.swift
//
//
//  Created by Kayla Hoyet on 7/5/21
//  Modified by hugh@blinkybeach.com
//

import Foundation

public struct Country: Codable, Identifiable, Hashable {
    public let countryId: Int
    public let name: String
    public let iso3166a2: String
    public let iso3166a3: String
    
    public var id: Int { get { return self.countryId } }
    public var enumeratedId: Self.Id { get {
        return Self.Id(rawValue: self.countryId)!
    } }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.countryId)
    }
    
    private enum CodingKeys: String, CodingKey {
        case countryId = "country_id"
        case name
        case iso3166a2 = "iso_3166_a2"
        case iso3166a3 = "iso_3166_a3"
    }
    
    private init(
        _ countryId: Self.Id,
        _ name: String,
        _ iso3166a2: String,
        _ iso3166a3: String
    ) {
        self.countryId = countryId.rawValue
        self.name = name
        self.iso3166a2 = iso3166a2
        self.iso3166a3 = iso3166a3
        return
    }
    
    public enum Id: Int {
    
        case Australia = 1
        case NewZealand = 2
    }
    
    public static let all = [
        Country(.Australia, "Australia", "AU", "AUS"),
        Country(.NewZealand, "New Zealand", "NZ", "NZL")
    ]
    
    public static func withId(_ id: Self.Id) -> Country {
        for country in Self.all {
            if country.enumeratedId == id { return country }
        }
        fatalError("Unknown Country ID \(id.rawValue)")
    }
}
