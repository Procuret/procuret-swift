//
//  FailedPayment.swift
//  
//
//  Created by Kayla Hoyet on 4/13/23.
//

import Foundation

public struct FailedPayment: Codable, Identifiable {
    
    internal static let path = "/failed-payment"
    internal static let listPath = "/failed-payment/list"
    
    public let publicId: String
    public let failed: Date
    public let relatedTransactions: Array<RelatedTransaction>
    public let method: PaymentMethodHeadline
    public let amount: Amount
    public let failureMode: PaymentFailureMode?
    public let customer: EntityHeadline
    public let due24hrsStarting: Date
    public let errorReport: ErrorReport?
    public let disposition: Disposition
    
    public var id: String { get { return self.publicId } }
    
    public enum OrderBy: String {
        case failed = "failed"
    }
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case failed
        case relatedTransactions = "related_transactions"
        case method
        case amount
        case failureMode = "failure_mode"
        case customer
        case due24hrsStarting = "due_24hrs_starting"
        case errorReport = "error_report"
        case disposition
    }
    
    public static func retrieveMany(
        limit: Int = 20,
        offset: Int = 0,
        order: Order = .descending,
        orderBy: FailedPayment.OrderBy = .failed,
        anyFragment: String?,
        methodId: String?,
        seriesId: String?,
        failureMode: PaymentFailureMode?,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, Array<Self>?) -> Void
    ) {
        
        typealias UP = UrlParameter
        
        Request.make(
            path: self.listPath,
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
