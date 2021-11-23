//
//  PrincipalInvitation.swift
//  
//
//  Created by Kayla Hoyet on 11/23/21.
//

import Foundation

public struct PrincipalInvitation: Codable {
    
    internal static let path = "/business/principal-invitation"
    
    let amount: Amount
    let invoiceId: String
    let identifier: EntityIdentifier
    let entityAddress: Address
    let inviteeEmail: String
    
    private enum CodingKeys: String, CodingKey {
        case amount
        case invoiceId = "invoice_id"
        case identifier = "entity_id"
        case entityAddress = "address"
        case inviteeEmail = "invitee_email"
    }
    
    public static func create(
        supplierEntityId: String,
        businessEntityId: String,
        amount: Amount,
        invoiceId: String,
        inviteeEmail: String,
        session: Session?,
        callback: @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                supplierEntityId: supplierEntityId,
                businessEntityId: businessEntityId,
                amount: amount,
                invoiceId: invoiceId,
                inviteeEmail: inviteeEmail
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let supplierEntityId: String
        let businessEntityId: String
        let amount: Amount
        let invoiceId: String
        let inviteeEmail: String
    
        private enum CodingKeys: String, CodingKey {
            case supplierEntityId = "supplier_id"
            case businessEntityId = "business_id"
            case amount = "denomination_id"
            case invoiceId = "invoice_id"
            case inviteeEmail = "invitee_email"
        }
    }
}
