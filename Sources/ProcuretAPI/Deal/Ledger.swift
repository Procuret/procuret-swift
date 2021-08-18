//
//  Ledger.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct DealLedger: Codable {
    
    internal static let path = Deal.path + "/ledger"
    
    let commitmentId: String
    let lines: Array<DealLedgerLine>
    let rate: String
    
    public enum CodingKeys: String, CodingKey {
        case commitmentId = "commitment_id"
        case lines
        case rate
    }
    
    public static func retrieve (
        commitmentId: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
        ) {
            Request.make(
                path: self.path,
                payload: CreateParameters(commitmentId: commitmentId),
                session: nil,
                query: nil,
                method: .GET
            ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreateParameters: Codable {
        let commitmentId: String
        
        private enum CodingKeys: String, CodingKey {
            case commitmentId = "commitment_id"
        }
    }
}
