//
//  Mechanism.swift
//  
//
//  Created by Kayla Hoyet on 4/20/23.
//

import Foundation

public enum PaymentMechanism: Int, Codable, CaseIterable, Identifiable,
                              Equatable, Sendable {
    
    case onPlatform = 1
    case offPlatform = 2
    case stripe = 3
    case mecUnknown = 4
    
    public var name: String { get {
        switch self {
        case .onPlatform:
            return "On Platform"
        case .offPlatform:
            return "Off Platform"
        case .stripe:
            return "Stripe Subscription"
        case .mecUnknown:
            return "Unknown"
        }
    }}
    
    public var id: Int { get { return self.rawValue } }
}
