//
//  Invoice.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct Invoice: Codable, Sendable {
    
    internal static let path = "/invoice"
    
    internal static func create(
        supplierId: Int,
        invoiceFilename: String,
        invoiceIdentifier: String,
        contentDescription: String,
        invoiceeBusinessId: Int?,
        deliveredDate: Date?,
        invoiceBase64: String,
        magnitudeValue: Decimal,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, Invoice?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                supplierId: supplierId,
                invoiceFilename: invoiceFilename,
                invoiceIdentifier: invoiceIdentifier,
                contentDescription: contentDescription,
                invoiceeBusinessId: invoiceeBusinessId,
                deliveredDate: deliveredDate,
                invoiceBase64: invoiceBase64,
                magnitudeValue: magnitudeValue
            ),
            session: nil,
            query: nil,
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable, Sendable {
        let supplierId: Int
        let invoiceFilename: String
        let invoiceIdentifier: String
        let contentDescription: String
        let invoiceeBusinessId: Int?
        let deliveredDate: Date?
        let invoiceBase64: String
        let magnitudeValue: Decimal
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case invoiceFilename = "invoice_filename"
            case invoiceIdentifier = "invoice_identifier"
            case contentDescription = "content_description"
            case invoiceeBusinessId = "invoicee_business_id"
            case deliveredDate = "delivered_date"
            case invoiceBase64 = "invoice_base64"
            case magnitudeValue = "magnitude_value"
        }
    }
}
