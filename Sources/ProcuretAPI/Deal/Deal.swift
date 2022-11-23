//
//  Deal.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation

public struct Deal: Codable, Identifiable {
    
    internal static let path = "/deal"
    internal static let listPath = Deal.path + "/list"
    
    public let setupId: String
    public let commitmentId: String
    public let transactingHumanId: Int
    public let transactingHumanName: String
    public let creditAssessmentState: AssessmentState
    public let supplier: EntityHeadline
    public let business: EntityHeadline
    public let timeCommitted: String
    public let invoiceValue: String
    public let totalPayable: String
    public let sumPayments: String
    public let denomination: Currency
    public let disposition: Disposition
    public let id = UUID()
    
    public enum CodingKeys: String, CodingKey {
        case setupId = "setup_id"
        case commitmentId = "commitment_id"
        case transactingHumanId = "transacting_human_id"
        case transactingHumanName = "transacting_human_name"
        case creditAssessmentState = "credit_assessment_state"
        case supplier
        case business
        case timeCommitted = "time_committed"
        case invoiceValue = "invoice_value"
        case totalPayable = "total_payable"
        case sumPayments = "sum_payments"
        case denomination
        case disposition
    }
    
    public enum OrderBy: String {
        case supplierName = "supplier_name"
        case created = "created"
        case businessName = "business_name"
        case value = "value"
        case outstanding = "outstanding"
    }
    
    public static func retrieve(
        commitmentId: String,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Deal?) -> Void
    ) {
        Request.make(
            path: self.path,
            data: nil,
            session: session,
            query: QueryString(
            targetsOnly: [UrlParameter(commitmentId, key: "commitment_id")]
            ),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    public static func retrieveMany(
        limit: Int,
        offset: Int,
        order: Order,
        orderBy: Deal.OrderBy,
        anyNameFragment: String?,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Array<Deal>?) -> Void
    ) {
        Request.make(
            path: Deal.listPath,
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
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
            return
        }
    }
}
