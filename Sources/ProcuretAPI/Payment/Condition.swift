//
//  Condition.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct SeriesCondition: Codable {
    
    internal static let listPath = "/series/condition/list"
    
    let indexid: Int
    let name: String
    
    public enum CodingKeys: String, CodingKey {
        case indexid
        case name
    }
    
    public static func retrieveFulfilled(
        commitmentId: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.listPath,
            payload: RetrieveParameters(commitmentId: commitmentId),
            session: session,
            query: nil,
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    private struct RetrieveParameters: Codable {
        let commitmentId: String
        
        private enum CodingKeys: String, CodingKey {
            case commitmentId = "commitment_id"
        }
    }
}


