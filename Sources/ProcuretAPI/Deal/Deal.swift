//
//  Deal.swift
//  
//
//  Created by Kayla Hoyet on 7/28/21.
//

import Foundation
import XCTest

public struct Deal: Codable {
    
    internal static let path = "/deal"
    internal static let listPath = Deal.path + "/list"
    
    let setupId: String
    let commitmentId: String
    let transactingHumanId: Int
    let transactingHumanName: String
    let creditAssessmentState: AssessmentState
    let supplier: EntityHeadline
    let business: EntityHeadline
    let timeCommitted: String
    let invoiceValue: String
    let totalPayable: String
    let sumPayments: String
    let denomination: Currency
    let disposition: Disposition
    
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
        session: Session?,
        callback: @escaping (Error?, Deal?) -> Void
    ) {
        Request.make(
            path: self.path,
            data: nil,
            session: session,
            query: QueryString(
            targetsOnly: [UrlParameter(commitmentId, key: "commitment_id")]
            ),
            method: .GET
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
        session: Session?,
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
            method: .GET
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
            return
        }
    }
}
