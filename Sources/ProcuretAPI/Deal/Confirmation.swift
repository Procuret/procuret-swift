//
//  Confirmation.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct DealConfirmation: Codable {
    
    let seriesId: String
    let created: ProcuretTime
    let sentTo: String
    
    public enum CodingKeys: String, CodingKey {
        case seriesId = "series_public_id"
        case created
        case sentTo = "sent_to"
    }
    
    public static func retrieveMany (
        seriesId: String?,
        commitmentId: String?,
        session: Session?,
        callback: @escaping (Error?, DealConfirmation?) -> Void
        ) {
        fatalError("Not implemented")
        }
}
