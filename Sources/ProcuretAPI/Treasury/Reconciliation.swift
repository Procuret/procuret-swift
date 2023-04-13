//
//  Reconciliation.swift
//  
//
//  Created by Kayla Hoyet on 4/13/23.
//

import Foundation

public struct Reconciliation: Codable, Identifiable, Hashable {
    
    public let indexId: Int
    public let name: String
    
    public var id: Int { get { return self.indexId; } }
    
    private enum CodingKeys: String, CodingKey {
        case indexId = "indexid"
        case name
    }
    
    private init(
        _ id: Self.ReconciliationConstant,
        _ name: String
    ) {
        self.indexId = id.rawValue
        self.name = name
        return
    }
    
    public enum ReconciliationConstant: Int {
        case stripe = 1
        case xero = 2
        case manual = 3
    }
}
