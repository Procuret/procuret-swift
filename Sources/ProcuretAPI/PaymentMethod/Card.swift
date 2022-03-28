//
//  Card.swift
//  
//
//  Created by Kayla Hoyet on 8/10/21.
//

import Foundation

public struct Card: UnderpinnedByMethodKernel {
    
    internal static let path = "/payment/method/card"
    
    public let kernel: PaymentMethodKernel
    public let details: CardDetails
    
    public var endsIn: String { get {
        return self.details.last4
    } }
    
    public var friendlyDescription: String { get {
        return self.details.brand ?? "Card" + " ..." + self.details.last4
    } }

    private enum CodingKeys: String, CodingKey {
        case kernel
        case details = "card_details"
    }

}
