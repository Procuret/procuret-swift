//
//  Designated.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct DesignatedPaymentMethod: Codable {
    
    let seriesId: String
    let methodId: String
    
    public enum CodingKeys: String, CodingKey {
        case seriesId = "series_id"
        case methodId = "method_id"
    }
    
    public static func create (
        seriesId: String,
        methodId: String,
        session: Session?,
        callback: @escaping (Error?) -> Void
    ) {
        fatalError("Not implemented")
    }
}
