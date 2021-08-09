//
//  InstalmentLinkOpen.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct InstalmentLinkOpen: Codable {
    
    internal static let path = InstalmentLink.path + "/open"
    
    let sequence: Int
    let created: String
    
    public enum CodingKeys: String, CodingKey {
        case sequence
        case created
    }
    
    public static func create (
        instalmentLinkId: String,
        session: Session?,
        callback: @escaping (Error?) -> Void
    ) {
        fatalError("Not implemented")
    }
}
