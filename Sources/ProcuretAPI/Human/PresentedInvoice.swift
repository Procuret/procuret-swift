//
//  PresentedInvoice.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct PresentedInvoice: Codable {
    
    internal static let path = "/human/presented-invoice"
    
    let publicId: String
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
    }
    
    public static func create(
        amount: Decimal,
        supplierId: Int,
        invoiceIdentifier: String,
        preferredPeriods: Int,
        session: Session?,
        callback: @escaping (Error?, Human?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                amount: amount,
                supplierId: supplierId,
                invoiceIdentifier: invoiceIdentifier,
                preferredPeriods: preferredPeriods
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    private struct CreatePayload: Codable {
        let amount: Decimal
        let supplierId: Int
        let invoiceIdentifier: String
        let preferredPeriods: Int
        
        private enum CodingKeys: String, CodingKey {
            case amount
            case supplierId = "supplier_id"
            case invoiceIdentifier = "identifier"
            case preferredPeriods = "preferred_periods"
        }
    }
}
