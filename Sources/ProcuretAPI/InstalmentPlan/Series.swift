//
//  Series.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct PaymentSeries: Codable, Identifiable, Equatable {
    
    internal static let path = "/payment/series"
    internal static let listPath = PaymentSeries.path + "/list"
    
    public enum OrderBy: String {
        case created = "created"
    }
    
    public let created: Date
    public let publicId: String
    public let creatingAgent: Int
    public let paymentMethod: PaymentMethodHeadline?
    public let customer: EntityHeadline
    public let supplier: EntityHeadline
    public let exchangeId: String
    public let identifier: String
    public let amount: Amount
    public let totalPayable: Amount
    public let sumPayments: Amount
    public let completed: Bool
    public let commitmentId: String
    public let mechanism: PaymentMechanism?
    public let allowsSelfServePayments: Bool
    public let oldestUnpaidInstalmentDue24hrsStarting: Date?
    public let disposition: Disposition
    
    public var outstanding: Amount { get {
        return self.totalPayable - self.sumPayments
    } }

    public var id: String { get { return self.publicId } }
    
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
        case completed
        case commitmentId = "commitment_id"
        case mechanism
        case allowsSelfServePayments = "allows_self_serve_payments"
        case oldestUnpaidInstalmentDue24hrsStarting =
                "oldest_unpaid_instalment_due_24hrs_starting"
        case disposition
    }
    
    public static func retrieve(
        session: SessionRepresentative,
        publicId: String,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        
        typealias UP = UrlParameter
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [UP(publicId, key: "public_id")]
            ),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
        
    }
    
    public static func retrieveMany(
        session: SessionRepresentative,
        limit: Int = 20,
        offset: Int = 0,
        order: Order = .descending,
        orderBy: Self.OrderBy = .created,
        textFragment: String? = nil,
        business: Business? = nil,
        method: PaymentMethod? = nil,
        completed: Bool? = nil,
        paymentMechanism: PaymentMechanism? = nil,
        hasOverdueInstalement: Bool? = nil,
        instrument: Instrument? = nil,
        instalmentDueBefore: Date? = nil,
        instalmentDueAtOrAfter: Date? = nil,
        minOverdueDays: Int? = nil,
        maxOverdueDays: Int? = nil,
        collectionsUpToDate: Bool? = nil,
        withModifiedInvoice: Bool? = nil,
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
                    UP.optionally(textFragment, key: "fragment"),
                    UP.optionally(
                        business?.entity.publicId,
                        key: "business_id"
                    ),
                    UP.optionally(method?.publicId, key: "method_id"),
                    UP.optionally(completed, key: "completed"),
                    UP.optionally(paymentMechanism, key: "payment_mechanism"),
                    UP.optionally(
                        hasOverdueInstalement,
                        key: "has_overdue_instalment"
                    ),
                    UP.optionally(instrument, key: "active_instrument"),
                    UP.optionally(
                        instalmentDueBefore,
                        key: "instalment_due_before"
                    ),
                    UP.optionally(
                        instalmentDueAtOrAfter,
                        key: "instalment_due_at_or_after"
                    ),
                    UP.optionally(minOverdueDays, key: "min_overdue_days"),
                    UP.optionally(maxOverdueDays, key: "max_overdue_days"),
                    UP.optionally(
                        collectionsUpToDate,
                        key: "collections_up_to_date"
                    ),
                    UP.optionally(
                        withModifiedInvoice,
                        key: "with_modified_invoice"
                    )
                ].compactMap { $0 }
            ),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
            return
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return (
            lhs.publicId == rhs.publicId
            && lhs.totalPayable == rhs.totalPayable
            && lhs.sumPayments == rhs.sumPayments
            && lhs.completed == rhs.completed
            && lhs.mechanism == rhs.mechanism
            && lhs.allowsSelfServePayments == rhs.allowsSelfServePayments
            && lhs.oldestUnpaidInstalmentDue24hrsStarting
                == rhs.oldestUnpaidInstalmentDue24hrsStarting
        )
    }

}
