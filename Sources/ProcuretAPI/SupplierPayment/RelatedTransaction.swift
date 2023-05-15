//
//  RelatedTransaction.swift
//  
//
//  Created by Kayla Hoyet on 4/6/23.
//

import Foundation

public struct RelatedTransaction: Codable, Equatable {
    
    public let transactionType: TransactionType
    public let transactionId: String
    
    public enum CodingKeys: String, CodingKey {
        case transactionType = "transaction_type"
        case transactionId = "transaction_id"
    }

}


