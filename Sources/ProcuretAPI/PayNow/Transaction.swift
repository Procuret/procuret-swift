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
        divisions: GenericProspectiveDivision,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, PayNowTransaction?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayloadWithMethod(
                divisions: divisions
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
    
    public static func create(
        amount: Amount,
        reference: String,
        businessId: String,
        supplierId: String,
        divisions: ProspectiveDivision,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, PayNowTransaction?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                amount: amount,
                reference: reference,
                businessId: businessId,
                supplierId: supplierId,
                divisions: divisions
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
    
    private struct CreatePayload: Codable {
        let amount: Amount
        let reference: String
        let businessId: String
        let supplierId: String
        let divisions: ProspectiveDivision
        
        private enum CodingKeys: String, CodingKey {
            case amount
            case reference
            case businessId = "business_id"
            case supplierId = "supplier_id"
            case divisions
        }
    }
    
    private struct CreatePayloadWithMethod: Codable {
        let divisions: GenericProspectiveDivision
        
        private enum CodingKeys: String, CodingKey {
            case divisions
        }
    }
}
