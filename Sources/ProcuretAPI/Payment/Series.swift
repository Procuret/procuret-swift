//
//  Series.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct PaymentSeries: Codable, Identifiable {
    
    internal static let path = "/payment/series"
    internal static let listPath = PaymentSeries.path + "/list"
    
    public let created: String
    public let publicId: String
    public let creatingAgent: Int
    public let paymentMethod: PaymentMethodHeadline
    public let customer: EntityHeadline
    public let supplier: EntityHeadline
    public let exchangeId: String
    public let identifier: String
    public let amount: Amount
    public let totalPayable: Amount
    public let sumPayments: Amount
    public let disposition: Disposition
    public let id = UUID()
    
    public enum CodingKeys: String, CodingKey {
        case created = "created"
        case publicId = "public_id"
        case creatingAgent = "creating_agent"
        case paymentMethod = "payment_method"
        case customer
        case supplier
        case exchangeId = "exchange_id"
        case identifier
        case amount
        case totalPayable = "total_payable"
        case sumPayments = "sum_payments"
        case disposition
    }
    
    public static func retrieveMany(
        limit: Int,
        offset: Int,
        order: Order,
        orderBy: PaymentSeriesOrderBy,
        textFragment: String?,
        businessId: String?,
        methodId: String?,
        session: Session?,
        callback: @escaping (Error?, Array<Self>?) -> Void
    ) {
        Request.make(
            path: Self.listPath,
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
