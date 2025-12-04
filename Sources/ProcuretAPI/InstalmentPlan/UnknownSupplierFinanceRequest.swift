//
//  File.swift
//  
//
//  Created by Hugh on 20/4/2023.
//

import Foundation


public struct UnknownSupplierFinanceRequest: Sendable {
    
    internal static let path = "/unknown-supplier-finance-request"
    
    public static func create(
        authenticatedBy session: SessionRepresentative,
        applicantHuman: Human,
        forCustomer business: Business,
        supplierIdentifier: EntityIdentifier,
        invoiceIdentifier: String,
        invoiceAmount: Amount,
        invoiceBodyBase64Encoded: Data,
        at endpoint: ApiEndpoint = .live,
        then callback: @Sendable @escaping (Error?) -> Void
    ) {
        
        guard let fileString = String(
            data: invoiceBodyBase64Encoded,
            encoding: .utf8
        ) else {
            callback(ProcuretError(
                .unprocessable,
                message: """
Unable to process invoice file data as UTF-8 bytes
"""
            ))
            return
        }
        
        Request.make(
            path: Self.path,
            payload: Self.CreatePayload(
                customer_entity_id: business.entity.publicId,
                applicant_human_id: applicantHuman.agentId,
                supplier_entity_identifier: supplierIdentifier,
                invoice_amount: invoiceAmount,
                invoice_identifier: invoiceIdentifier,
                invoice_file: fileString,
                file_extension: .pdf
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, _ in callback(error); return }
        
        return
        
    }
    
    public static func create(
        authenticatedBy session: SessionRepresentative,
        applicantHuman: Human,
        forCustomer business: Business,
        supplierIdentifier: EntityIdentifier,
        invoiceIdentifier: String,
        invoiceAmount: Amount,
        invoiceBody: Data,
        at endpoint: ApiEndpoint = .live,
        then callback: @Sendable @escaping (Error?) -> Void
    ) {
        
        guard let base64 = invoiceBody.base64EncodedString(
            options: [.lineLength76Characters]
        ).data(using: .utf8) else {
            callback(ProcuretError(.unprocessable, message: """
Unable to encode invoice body as UTF8 data
"""))
            return
        }
        
        return Self.create(
            authenticatedBy: session,
            applicantHuman: applicantHuman,
            forCustomer: business,
            supplierIdentifier: supplierIdentifier,
            invoiceIdentifier: invoiceIdentifier,
            invoiceAmount: invoiceAmount,
            invoiceBodyBase64Encoded: base64,
            at: endpoint,
            then: callback
        )
        
    }
    
    private struct CreatePayload: Encodable {
        
        let customer_entity_id: Int
        let applicant_human_id: Int
        let supplier_entity_identifier: EntityIdentifier
        let invoice_amount: Amount
        let invoice_identifier: String
        let invoice_file: String
        let file_extension: FileExtension
    }
    
}
