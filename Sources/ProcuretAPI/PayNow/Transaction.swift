//
//  Transaction.swift
//  
//
//  Created by Kayla Hoyet on 4/28/23.
//

import Foundation

public struct PayNowTransaction: Codable {
    
    internal static let path = "/pay-now-transaction"
    
    public let publicId: String
    public let supplier: EntityHeadline
    public let customer: Entity
    public let divisions: Array<PayNowDivision>
    public let reference: String
    public let amount: Amount
    public let created: Date
    public let customerFee: Amount?
    public let supplierFee: Amount?
    public let disposition: Disposition
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case supplier
        case customer
        case divisions
        case reference
        case amount
        case created
        case customerFee = "customer_fee"
        case supplierFee = "suppler_fee"
        case disposition
    }
    
    public static func create(
        authenticatedBy session: SessionRepresentative,
        amount: Amount,
        reference: String,
        business: Business,
        supplier: Supplier,
        method: IdentifiesPaymentMethod,
        at endpoint: ApiEndpoint = ApiEndpoint.live,
        then callback: @escaping (Error?, PayNowTransaction?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                amount: Amount(
                    magnitude: amount.magnitude,
                    denomination: amount.denomination
                ),
                reference: reference,
                customer_business_id: business.entity.publicId,
                supplier_id: supplier.entity.publicId,
                divisions: [ProspectiveDivision(
                    methodId: method.paymentMethodId,
                    magnitude: amount.asDecimalString()
                )]
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { e, d in
            Request.decodeResponse(e, d, Self.self, callback)
            return
        }
    }
    
    private struct CreatePayload: Encodable {
        let amount: Amount
        let reference: String
        let customer_business_id: Int
        let supplier_id: Int
        let divisions: Array<ProspectiveDivision>
        
    }
}
