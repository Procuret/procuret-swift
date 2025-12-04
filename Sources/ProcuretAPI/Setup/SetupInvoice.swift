//
//  SetupInvoice.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct SetupInvoice: Codable, Sendable {
    
    internal static let path = "/setup/invoice"
    
    let setupId: String
    let invoiceId: String
    
    private enum CodingKeys: String, CodingKey {
        case setupId = "setup_id"
        case invoiceId = "invoice_id"
    }
}
