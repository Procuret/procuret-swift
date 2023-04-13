//
//  ProspectivePayment.swift
//  
//
//  Created by Kayla Hoyet on 8/5/21.
//

import Foundation

public struct ProspectivePayment: Codable {
    
    internal static let path = "/credit/prospective-payment"
    
    public let rawPayment: String
    public let periods: Int
    
    public var payment: Decimal { get {
        return Decimal(string: self.rawPayment) ?? -1
    } }
    
    private enum CodingKeys: String, CodingKey {
        case rawPayment = "payment"
        case periods
    }
    
    public static func retrieve(
        principal: Decimal,
        cycle: Cycle,
        supplier: Supplier,
        periods: Int,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, ProspectivePayment?) -> Void
    ) {
        
        Request.make(
            path: self.path,
            data: nil,
            session: nil,
            query: QueryString([
                UrlParameter(1, key: "cycle"),
                UrlParameter(supplier.entity.publicId, key: "supplier_id"),
                // amusing spelling error in the API...
                UrlParameter(String(describing: principal), key: "principle"),
                UrlParameter(periods, key: "periods")
            ]),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
        }
    
    }
    
    public func amountGiven(
        denomination: Currency
    ) -> Amount {
        return Amount(
            magnitude: self.payment,
            denomination: denomination
        )
    }

}
