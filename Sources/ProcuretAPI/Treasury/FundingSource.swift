//
//  FundingSource.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct FundingSource: Codable {
    
    internal static let path = "/treasury/funding-source"
    internal static let listPath = FundingSource.path + "/list"
    
    let indexid: Int
    let name: String
    let disposition: Disposition
    
    private enum CodingKeys: String, CodingKey {
        case indexid
        case name
        case disposition
    }
    
    public static func create(
        name: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(name: name),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
                fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        indexid: Int,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(indexid: indexid),
            session: session,
            query: nil,
            method: .GET
        ) { error, data in
            fatalError("Not implemented")
        }
    }
                
    private struct CreatePayload: Codable {
        let name: String
                    
        private enum CodingKeys: String, CodingKey {
            case name
        }
    }
    
    private struct RetrieveParameters: Codable {
        let indexid: Int
        
        private enum CodingKeys: String, CodingKey {
            case indexid
        }
    }
}

