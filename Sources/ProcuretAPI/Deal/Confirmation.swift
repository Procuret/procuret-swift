//
//  Confirmation.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct DealConfirmation: Codable {
    
    internal static let path = "/deal-confirmation"
    internal static let listPath = DealConfirmation.path + "/list"
    
    let seriesId: String
    let created: Date
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
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, DealConfirmation?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveManyParameters(
                seriesId: seriesId,
                commitmentId: commitmentId
            ),
            session: session,
            query: nil,
            method: .GET,
            endpoint: endpoint
        ) { error, data in
                fatalError("Not implemented")
        }
    }
        
    private struct RetrieveManyParameters: Codable {
        let seriesId: String?
        let commitmentId: String?
            
        private enum CodingKeys: String, CodingKey {
            case seriesId = "series_id"
            case commitmentId = "commitment_id"
        }
    }
}
