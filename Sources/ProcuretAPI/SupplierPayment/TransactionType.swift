//
//  TransactionType.swift
//  
//
//  Created by Kayla Hoyet on 4/12/23.
//

import Foundation

public enum TransactionType: Int, Codable, CaseIterable, Equatable, Sendable {
        
    case payNow = 1
    case instalmentPlan = 2
        
    public var name: String {
        get {
            switch self {
            case .payNow:
                return "Pay Now"
            case .instalmentPlan:
                return "Instalment Plan"
            }
        }
    }
}

