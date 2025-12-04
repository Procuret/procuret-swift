//
//  Instrument.swift
//  
//
//  Created by Kayla Hoyet on 2/16/22.
//  Modified by Hugh Jeremy on 28 Mar 2022
//

import Foundation

public enum Instrument: Int, Codable, CaseIterable, Identifiable, Sendable {
    
    case card = 1
    case bankAccount = 2
    
    public var name: String { get {
        switch self {
        case .card:
            return "Card"
        case .bankAccount:
            return "Bank Account"
        }
    } }
    
    public var id: Int { get { return self.rawValue } }
    
}
