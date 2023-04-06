//
//  RelatedTransaction.swift
//  
//
//  Created by Kayla Hoyet on 4/6/23.
//

import Foundation

public enum RelatedTransaction: Int, Codable, CaseIterable, Identifiable {
    
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
    
    public var id: Int { get { return self.rawValue } }
}
