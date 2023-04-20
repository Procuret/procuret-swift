//
//  File.swift
//  
//
//  Created by Hugh on 20/4/2023.
//

import Foundation


public struct UnknownSupplierFinanceRequest {
    
    internal static let path = "/unknown-supplier-finance-request"
    
    static func create(
        authenticatedBy session: SessionRepresentative,
        forCustomer business: Business,
        supplierIdentifier: EntityIdentifier,
        invoiceIdentifier: String,
        invoiceAmount: Amount,
        invoiceBody: Data,
        at endpoint: ApiEndpoint = .live,
        then callback: @escaping (Error?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            payload: Self.CreatePayload(
                customer_entity_id: business.entity.publicId,
                supplier_entity_identifier: supplierIdentifier,
                invoice_amount: invoiceAmount,
                invoice_identifier: invoiceIdentifier,
                invoice_body: invoiceBody.base64EncodedString(
                    options: [.lineLength76Characters]
                )
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, _ in callback(error); return }
        
        return
        
    }
    
    private struct CreatePayload: Encodable {
        
        let customer_entity_id: Int
        let supplier_entity_identifier: EntityIdentifier
        let invoice_amount: Amount
        let invoice_identifier: String
        let invoice_body: String
    }
    
}
