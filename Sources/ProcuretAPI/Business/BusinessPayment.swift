//
//  File.swift
//  
//
//  Created by Kayla Hoyet on 4/6/23.
//

import Foundation

public struct BusinessPayment: Codable, Identifiable {
    
    internal static let path = "/business/payment"
    internal static let listPath = "/businesss/payment/list"
    
    public let publicId: String
    public let created: Date
    public let executed: Date
    public let relatedTransaction: RelatedTransaction?
    public let amount: Amount
    public let method: PaymentMethodHeadline?
    public let disposition: Disposition
    
    public var id: String { get { return self.publicId } }

    public enum OrderBy: String {
        case created = "created"
    }
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case created
        case executed
        case relatedTransaction = "related_transaction"
        case amount
        case method = "payment_method"
        case disposition
    }
    
    public static func retrieveMany(
        limit: Int = 20,
        offset: Int = 0,
        order: Order = .descending,
        orderBy: Self.OrderBy = .created,
        textFragment: String? = nil,
        businessId: String? = nil,
        methodId: String? = nil,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Array<Self>?) -> Void
    ) {
        
        typealias UP = UrlParameter
        
        Request.make(
            path: Self.listPath,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [
                    UP(limit, key: "limit"),
                    UP(offset, key: "offset"),
                    UP(order, key: "order"),
                    UP(orderBy, key: "order_by"),
                    UP.optionally(textFragment, key: "any_fragment"),
                    UP.optionally(businessId, key: "business_id"),
                    UP.optionally(methodId, key: "method_id")
                ].compactMap { $0 }
            ),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
            return
        }
    }

}

