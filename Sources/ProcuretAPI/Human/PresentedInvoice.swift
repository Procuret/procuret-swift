//
//  PresentedInvoice.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct PresentedInvoice: Codable {
    
    let publicId: String
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
    }
    
    public static func create (
        amount: Float,
        supplierId: Int,
        invoiceIdentifier: String,
        preferredPeriods: Int,
        session: Session?,
        callback: @escaping (Error?, Human?) -> Void
        ) {
        fatalError("Not implemented")
        }
}
