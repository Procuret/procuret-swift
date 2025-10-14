//
//  Brand.swift
//  
//
//  Created by Kayla Hoyet on 7/23/21.
//

import Foundation

public struct Brand: Codable, Equatable, Hashable {
    
    internal static let path = "/entity/brand"
    
    public let entityId: Int
    public let name: String
    public let saleMessage: String
    public let created: String
    public let media: Array<Self.Media>

    
    public enum CodingKeys: String, CodingKey {
        case entityId = "entity_id"
        case name
        case saleMessage = "sale_message"
        case created
        case media
    }
    
    public static func create(
        name: String,
        media: Array<BrandMedia>,
        saleMessage: String,
        entityId: String,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Brand?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                name: name,
                media: media,
                saleMessage: saleMessage,
                entityId: entityId
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
        
    private struct CreatePayload: Codable {
        let name: String
        let media: Array<BrandMedia>
        let saleMessage: String
        let entityId: String
        
            
        private enum CodingKeys: String, CodingKey {
            case name = "brand_name"
            case media
            case saleMessage = "sale_message"
            case entityId = "entity_id"
        }
    }

    public struct Colour {
        
        public let hex: String
        
        public var prefixedHex: String { get { return "#\(self.hex)"} }

    }
    
    public struct Media: Codable, Equatable, Hashable {
        
        public enum Scheme: Int, Codable, CaseIterable, Identifiable {
            case dark = 2
            case light = 1
            
            public var id: Int { get { return self.rawValue } }
        }
        
        private enum CodingKeys: String, CodingKey {
            case scheme
            case rawPrimaryColour = "primary_colour_hex"
            case rawAccentColour = "accent_colour_hex"
            case _logoUrl = "logo_url"
        }
        
        public let scheme: Self.Scheme
        public let rawPrimaryColour: String
        public let rawAccentColour: String
        private let _logoUrl: String?
        
        public var logoUrl: String {
            
            if let lu = self._logoUrl { return lu }
            
            switch self.scheme {
                
            case .light: return """
https://procuret.com/content/branding/20201104_PR_Procuret_Logo.svg
"""
            case .dark: return """
https://procuret.com/content/branding/20201104_PR_Procuret_Logo_White.svg
"""
            }
            
        }

        public var primaryColour: Brand.Colour { get {
            return Brand.Colour(hex: self.rawPrimaryColour)
        } }
        public var accentColour: Brand.Colour { get {
            return Brand.Colour(hex: self.rawAccentColour)
        } }
    
    }

}
