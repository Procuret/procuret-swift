//
//  ProspectiveFee.swift
//  
//
//  Created by Hugh on 13/4/2023.
//
import Foundation

public struct ProspectiveFee: Decodable {
    
    internal static let path: String = "/pay-now-transaction/fee/prospective"
    
    public let amount: Amount
    public let rawPercentage: String
    public let feeMode: PayNowFeeMode
    
    public var percentage: Decimal { get {
        return Decimal(string: self.rawPercentage) ?? -1
    } }
    
    private enum CodingKeys: String, CodingKey {
        
        case amount
        case rawPercentage = "percentage"
        case feeMode = "fee_mode"
        
    }
    
    public static func calculate(
        authenticatedBy session: SessionRepresentative,
        supplier: Supplier,
        amount: Amount,
        method: PaymentMethod,
        at endpoint: ApiEndpoint = .live,
        then callback: @escaping (Error?, Self?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            payload: Self.CreatePayload(
                supplier_id: supplier.entity.publicId,
                amount: amount,
                divisions: [Self.Division(
                    method_id: method.publicId,
                    magnitude: amount.asDecimalString()
                )]
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
        
        return
        
    }
    
    private struct Division: Encodable {
        let method_id: String
        let magnitude: String
    }
    
    private struct CreatePayload: Encodable {
        let supplier_id: Int
        let amount: Amount
        let divisions: Array<ProspectiveFee.Division>
    }
    
    
}
