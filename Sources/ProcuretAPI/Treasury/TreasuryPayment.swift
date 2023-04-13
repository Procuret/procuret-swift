//
//  Payment.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct TreasuryPayment: Codable, Identifiable {
    
    internal static let path = "/treasury/payment"
    internal static let listPath = TreasuryPayment.path + "/list"
    
    let publicId: String
    let executor: HumanHeadline
    let created: Date
    let executed: Date
    let relatedTransaction: RelatedTransaction?
    let magnitude: String
    let reconciliation: Array<Reconciliation>?
    let creatingAgentId: Int?
    let method: PaymentMethodHeadline?
    let denomination: Currency
    let active: Bool
    let refunds: Array<RefundHeadline>?
    let disposition: Disposition
    
    public var id: String { get { return self.publicId; } }
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case executor
        case created
        case executed
        case relatedTransaction = "related_transaction"
        case magnitude
        case reconciliation
        case creatingAgentId = "creating_agent_id"
        case method
        case denomination
        case active
        case refunds
        case disposition
    }
    
    public static func create(
        amount: String,
        denomination: Currency,
        executorId: Int,
        executionTime: Date,
        paymentMethodId: String?,
        seriesId: String?,
        manuallyReconciled: Bool?,
        active: Bool,
        existingToUpdate: Self?,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                amount: amount,
                denomination: denomination,
                executorId: executorId,
                executionTime: executionTime,
                paymentMethodId: paymentMethodId,
                seriesId: seriesId,
                manuallyReconciled: manuallyReconciled,
                active: active,
                existingToUpdate: existingToUpdate
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    public static func retrieve(
        publicId: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [
                    UrlParameter(
                        publicId, key: "public_id"
                    )
                ]
            ),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    private struct CreatePayload: Codable {
        let amount: String
        let denomination: Currency
        let executorId: Int
        let executionTime: Date
        let paymentMethodId: String?
        let seriesId: String?
        let manuallyReconciled: Bool?
        let active: Bool
        let existingToUpdate: TreasuryPayment?
        
        private enum CodingKeys: String, CodingKey {
            case amount = "magnitude"
            case denomination = "currency_id"
            case executorId = "executor_agent_id"
            case executionTime = "execution_time"
            case paymentMethodId = "payment_method_id"
            case seriesId = "series_id"
            case manuallyReconciled = "manually_reconciled"
            case active
            case existingToUpdate = "public_id"
        }
    }
}
