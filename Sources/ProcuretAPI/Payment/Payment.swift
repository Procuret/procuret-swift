//
//  Payment.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct Payment: Codable {
    
    internal static let path = "/payment"
    
    internal static let insufficient_funds: String =
    """
    Your financial institution reports that
    your card has insufficient funds available. You could try adding
    funds, or try using a different card.
    """

}
