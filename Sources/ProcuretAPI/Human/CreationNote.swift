//
//  CreationNote.swift
//  
//
//  Created by Kayla Hoyet on 7/22/21.
//

import Foundation

public struct CreationNote: Codable {
    
    internal static let path = "/creation-note"
    
    let humanId: String
    let note: Note
    
    public enum CodingKeys: String, CodingKey {
        case humanId = "human_id"
        case note
    }
    
    public static func retrieve(
        humanId: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(humanId: humanId),
            session: session,
            query: nil,
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let humanId: String
        
        private enum CodingKeys: String, CodingKey {
            case humanId = "human_id"
        }
    }
}

