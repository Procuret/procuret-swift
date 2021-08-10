//
//  Card.swift
//  
//
//  Created by Kayla Hoyet on 8/10/21.
//

import Foundation

public struct Card: Codable {
    
    internal static let path = "/payment/method/card"
    
    let kernel: PaymentMethodKernel
    let details: CardDetails
    
    private enum CodingKeys: String, CodingKey {
        case kernel
        case details
    }
}
