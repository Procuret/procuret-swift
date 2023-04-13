//
//  Record.swift
//  
//
//  Created by Kayla Hoyet on 4/13/23.
//

import Foundation

public enum Record: Codable {
    case failedPayment(FailedPayment)
    case payment(TreasuryPayment)
    case prolongedPayment(ProlongedPayment)
}
