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
    
    public static func create(
        instalmentLinkId: String,
        session: Session?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(instalmentLinkId: instalmentLinkId),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let instalmentLinkId: String
        
        private enum CodingKeys: String, CodingKey {
            case instalmentLinkId = "link_id"
        }
    }
}
