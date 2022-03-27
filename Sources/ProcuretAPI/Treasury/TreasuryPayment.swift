//
//  Payment.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct TreasuryPayment: Codable {
    
    internal static let path = "/treasury/payment"
    internal static let listPath = Payment.path + "/list"
    
    let publicId: String
    let executor: HumanHeadline
    let created: Date
    let executed: Date
    let magnitude: String
    let reconciliations: Array<Reconciliation>?
    let creatingAgentId: Int?
    let method: PaymentMethodHeadline?
    let denomination: Currency
    let disposition: Disposition
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case executor
        case created
        case executed
        case magnitude
        case reconciliations
        case creatingAgentId = "creating_agent_id"
        case method
        case denomination
        case disposition
    }
    
    public static func create(
        amount: String,
        denomination: Currency,
        executorId: Int,
        executionTime: Date,
        paymentMethodId: String?,
        commitmentId: String?,
        manuallyReconciled: Bool?,
        active: Bool,
        session: Session?,
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
                commitmentId: commitmentId,
                manuallyReconciled: manuallyReconciled,
                active: active
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
                fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        publicId: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(publicId: publicId),
            session: session,
            query: nil,
            method: .GET
        ) { error, data in
            fatalError("Not implemented")
        }
    }
                
    private struct CreatePayload: Codable {
        let amount: String
        let denomination: Currency
        let executorId: Int
        let executionTime: Date
        let paymentMethodId: String?
        let commitmentId: String?
        let manuallyReconciled: Bool?
        let active: Bool
                    
        private enum CodingKeys: String, CodingKey {
            case amount = "magnitude"
            case denomination = "currency_id"
            case executorId = "executor_agent_id"
            case executionTime = "execution_time"
            case paymentMethodId = "payment_method_id"
            case commitmentId = "commitment_id"
            case manuallyReconciled = "manually_reconciled"
            case active
        }
    }
    
    private struct RetrieveParameters: Codable {
        let publicId: String
        
        private enum CodingKeys: String, CodingKey {
            case publicId = "public_id"
        }
    }
}
