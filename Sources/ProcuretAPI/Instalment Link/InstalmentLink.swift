//
//  InstalmentLink.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct InstalmentLink: Codable {
    
    internal static let path = "/instalment-link"
    internal static let listPath = InstalmentLink.path + "/list"
    
    let publicId: String
    let supplier: EntityHeadline
    let created: String
    let inviteeEmail: String
    let invoiceAmount: String
    let invoiceIdentifier: String
    let opens: Array<InstalmentLinkOpen>
    let disposition: Disposition?
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case supplier
        case created
        case inviteeEmail = "invitee_email"
        case invoiceAmount = "invoice_amount"
        case invoiceIdentifier = "invoice_identifier"
        case opens
        case disposition
    }
    
    public static func create(
        supplierId: Int,
        amount: String,
        identifier: String,
        inviteeEmail: String,
        communicate: Bool,
        session: Session?,
        callback: @escaping (Error?, InstalmentLink?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                supplierId: supplierId,
                amount: amount,
                identifier: identifier,
                inviteeEmail: inviteeEmail,
                communicate: communicate
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        publicId: String,
        session: Session?,
        callback: @escaping (Error?, InstalmentLink?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(publicId: publicId),
            session: session,
            query: nil,
            method: .GET
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let supplierId: Int
        let amount: String
        let identifier: String
        let inviteeEmail: String
        let communicate: Bool
        
        private enum CodingKeys: String, CodingKey {
            case supplierId = "supplier_id"
            case amount
            case identifier = "invoice_identifier"
            case inviteeEmail = "invitee_email"
            case communicate
        }
    }
    
    private struct RetrieveParameters: Codable {
        let publicId: String
        
        private enum CodingKeys: String, CodingKey {
            case publicId = "public_id"
        }
    }
}
