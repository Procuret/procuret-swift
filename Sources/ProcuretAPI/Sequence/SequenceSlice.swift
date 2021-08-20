//
//  SequenceSlice.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct SequenceSlice: Codable {
    
    let scheduledTime: ProcuretTime
    let amount: Amount
    let paymentMethod: PaymentMethod
    
    private enum CodingKeys: String, CodingKey {
        case scheduledTime = "scheduled_time"
        case amount
        case paymentMethod = "payment_method"
    }
}
