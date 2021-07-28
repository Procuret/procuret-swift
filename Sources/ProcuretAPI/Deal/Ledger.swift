//
//  Ledger.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct DealLedger: Codable {
    
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
        fatalError("Not implemented")
        }
}
