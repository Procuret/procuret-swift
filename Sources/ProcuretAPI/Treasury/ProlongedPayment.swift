//
//  ProlongedPayment.swift
//  
//
//  Created by Kayla Hoyet on 4/13/23.
//

import Foundation

public struct ProlongedPayment: Codable, Identifiable {
    
    internal static let path = "/prolonged-payment"
    internal static let listPath = "/prolonged-payment/list"
    
    public let publicId: String
    public let relatedTransactions: Array<RelatedTransaction>
    public let method: PaymentMethodHeadline
    public let due24hrsStarting: Date
    public let expectedCompletion: Date
    public let started: Date
    public let created: Date
    public let completed: Date?
    public let failed: Date?
    public let amount: Amount
    public let disposition: Disposition
    
    public var id: String { get { return self.publicId } }
    
    public enum OrderBy: String {
        case started = "started"
    }
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case relatedTransactions = "related_transactions"
        case method
        case due24hrsStarting = "due_24hrs_starting"
        case expectedCompletion = "expected_completion"
        case started
        case created
        case completed
        case failed
        case amount
        case disposition
    }
    
    public static func retrieveMany(
        limit: Int = 20,
        offset: Int = 0,
        order: Order = .descending,
        orderBy: ProlongedPayment.OrderBy = .started,
        anyFragment: String?,
        methodId: String?,
        seriesId: String?,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Array<Self>?) -> Void
    ) {
        typealias UP = UrlParameter
        
        Request.make(
            path: "/prolonged-payment",
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [
                    UP(limit, key: "limit"),
                    UP(offset, key: "offset"),
                    UP(order, key: "order"),
                    UP(orderBy, key: "order_by")
                ].compactMap { $0 }
            ),
            method: .GET,
            endpoint: endpoint
        ) { e, d in
            Request.decodeResponse(e, d, Array<Self>.self, callback)
            return
        }
        
    }
}
