//
//  File.swift
//  
//
//  Created by Hugh on 17/4/2023.
//

import Foundation


public struct InstalmentPlanApplication: Sendable {
    
    internal static let path = "/magic-invoice"
    
    public static func create(
        authenticatedBy session: SessionRepresentative,
        supplier: Supplier,
        business: Business,
        invoiceIdentifier: String,
        invoiceAmount: Amount,
        months: Int,
        method: PaymentMethod? = nil,
        linkId: String? = nil,
        at endpoint: ApiEndpoint = .live,
        then callback: @Sendable @escaping (Error?) -> Void
    ) -> Void {
        
        Request.make(
            path: Self.path,
            payload: CreatePayload(
                supplier_id: supplier.entity.publicId,
                business_id: business.entity.publicId,
                invoice_id: invoiceIdentifier,
                invoice_amount: invoiceAmount,
                periods: months,
                link_id: linkId
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint,
            then: { error, _ in callback(error); return }
        )

        return

    }
    
    private struct CreatePayload: Encodable {

        let supplier_id: Int
        let business_id: Int
        let invoice_id: String
        let invoice_amount: Amount
        let periods: Int
        let link_id: String?

    }
    
}
