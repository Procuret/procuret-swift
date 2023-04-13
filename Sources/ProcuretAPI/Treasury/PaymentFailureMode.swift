//
//  PaymentFailureMode.swift
//  
//
//  Created by Kayla Hoyet on 4/13/23.
//

import Foundation

public enum PaymentFailureMode: Int, Codable, CaseIterable, Identifiable {
    
    case procuretError = 1
    case declined = 2
    case denominationNotSupported = 3
    case incorrectInstrumentDetail = 4
    case insufficientFunds = 5
    case potentiallyTransient = 6
    case cancelled = 7
    case otherRetryNotViable = 8
    case expired = 9 
    
    public var id: Int { get { return self.rawValue } }
    
}
