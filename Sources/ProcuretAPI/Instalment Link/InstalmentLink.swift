//
//  InstalmentLink.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct InstalmentLink: Codable {
    
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
    
    public static func retrieve (
        publicId: String,
        session: Session?,
        callback: @escaping (Error?, InstalmentLink?) -> Void
    ) {
        fatalError("Not implemented")
    }
    
    public static func create (
        supplierId: Int,
        amount: String,
        identifier: String,
        inviteeEmail: String,
        communicate: Bool,
        session: Session?,
        callback: @escaping (Error?, InstalmentLink?) -> Void
    ) {
        fatalError("Not implemented")
    }
}
