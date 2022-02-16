//
//  Method.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct PaymentMethod: Codable {
    
    internal static let path = "/payment/method"
    internal static let listPath = PaymentMethod.path + "/list"
    
    public enum OrderBy: String {
        case created = "created"
    }
    
    public static func retrieveMany(
        limit: Int,
        offset: Int,
        order: Order,
        orderBy: PaymentMethod.OrderBy,
        entityId: String?,
        authorityId: String?,
        active: Bool?,
        instrument: Instrument?,
        processor: Processor?,
        session: Session?,
        callback: @escaping (Error?, Array<PaymentMethod>?) -> Void
    ) {
        Request.make(
            path: PaymentMethod.listPath,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [
                    UrlParameter(limit, key: "limit"),
                    UrlParameter(offset, key: "offset"),
                    UrlParameter(order.rawValue, key: "descending"),
                    UrlParameter(orderBy.rawValue, key: "created")
                ]
            ),
            method: .GET
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
            return
        }
    }
}
