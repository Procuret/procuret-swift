//
//  SupplierFeeMode.swift
//  
//
//  Created by Kayla Hoyet on 4/28/23.
//

import Foundation

public struct SupplierPayNowFeeMode: Codable, Identifiable {
    
    internal static let path = "/supplier/pay-now-fee-mode"
    
    public let supplierId: String
    public let feeMode: PayNowFeeMode
    
    public var id: String { get { return self.supplierId; } }
    
    public enum CodingKeys: String, CodingKey {
        case supplierId = "supplier_id"
        case feeMode = "mode"
    }
    
    public static func retrieve(
        supplierId: String,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void 
    ) {
        
        Request.make(
            path: self.path,
            data: nil,
            session: session,
            query: QueryString([
                UrlParameter(supplierId, key: "supplier_id")
            ]),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented.")
        }
    }
}
