//
//  Region.swift
//
//
//  Created by Hugh Jeremy on 11/6/21.
//
import Foundation

public struct Region: Codable, Identifiable, Hashable {
    
    public let indexId: Int
    public let name: String
    public let abbreviation: String
    public let countryId: Int
    
    public var id: Int { get { return self.indexId; } }
    
    private enum CodingKeys: String, CodingKey {
        case indexId = "indexid"
        case name
        case abbreviation = "abbreviation"
        case countryId = "country_id"
    }
    
    private init(
        _ id: Self.AustralianRegionId,
        _ name: String,
        _ abbreviation: String,
        _ countryId: Country.Id
    ) {
        self.indexId = id.rawValue
        self.name = name
        self.abbreviation = abbreviation
        self.countryId = countryId.rawValue
        return
    }
    
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
    
    public static let australianRegions = [
        Region(.NSW, "New South Wales", "NSW", .Australia),
        Region(.VIC, "Victoria", "VIC", .Australia),
        Region(.QLD, "Queensland", "QLD", .Australia),
        Region(.SA, "South Australia", "SA", .Australia),
        Region(.WA, "Western Australia", "WA", .Australia),
        Region(.TAS, "Tasmania", "TAS", .Australia),
        Region(.NT, "Northern Territory", "NT", .Australia),
        Region(.ACT, "Australian Capital Territory", "ACT", .Australia)
    ]
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(self.indexId)
    }
    
    public static func regionsIn(country: Country) -> Array<Region> {
        switch country.enumeratedId {
        case .Australia:
            return Self.australianRegions
        case .NewZealand:
            return []
        }
    }
    
    public static func withId(_ id: Self.AustralianRegionId) -> Region {
        for region in Self.australianRegions {
            if region.indexId == id.rawValue { return region }
        }
        fatalError("Unknown Region ID \(id.rawValue)")
    }
    
}
