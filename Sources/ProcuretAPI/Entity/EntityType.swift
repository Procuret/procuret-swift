//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 25/3/2022.
//

import Foundation


public enum EntityType: Int, Codable, CaseIterable, Equatable {
    
    case company = 1
    case soleTrader = 2
    case strata = 3
    case trust = 4
    case partnership = 5
    case otherIncorporatedEntity = 6
    case ungroupedEntity = 7
    
    public var name: String { get {
        
        switch self {
        case .company:
            return "Company"
        case .soleTrader:
            return "Sole Trader"
        case .strata:
            return "Strata"
        case .trust:
            return "Trust"
        case .partnership:
            return "Partnership"
        case .otherIncorporatedEntity:
            return "Other Incorporated Entity"
        case .ungroupedEntity:
            return "Ungrouped"
        }

    } }

}
