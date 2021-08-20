//
//  Series.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct PaymentSeries: Codable {
    
    internal static let path = "/payment/series"
    internal static let listPath = PaymentSeries.path + "/list"
    
    let publicId: String
    let created: ProcuretTime
    let creatingAgent: String
    let paymentMethod: PaymentMethodHeadline
    let customer: EntityHeadline
    let supplier: EntityHeadline
    let exchangeId: String
    let amount: Amount
    let sumPayments: String
    let identifier: String
    let disposition: Disposition
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case created
        case creatingAgent = "creating_agent"
        case paymentMethod = "payment_method"
        case customer
        case supplier
        case exchangeId = "exchange_id"
        case amount
        case sumPayments = "sum_payments"
        case identifier
        case disposition
    }
    
    public static func create(
        paymentMethod: PaymentMethod,
        setupId: String,
        months: Int,
        session: Session?,
        callback: @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(paymentMethod: paymentMethod,
                setupId: setupId, months: months),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    public static func createWithCommitment(
        commitmentId: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        fatalError("Not implemented")
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
    
    public static func retrieveByCommitment(
        commitmentId: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveCommitment(commitmentId: commitmentId),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let paymentMethod: PaymentMethod
        let setupId: String
        let months: Int
        
        private enum CodingKeys: String, CodingKey {
            case paymentMethod = "payment_method_id"
            case setupId = "setup_id"
            case months = "periods"
        }
    }
    
    private struct RetrieveParameters: Codable {
        let publicId: String
        
        private enum CodingKeys: String, CodingKey {
            case publicId = "public_id"
        }
    }
    
    private struct RetrieveCommitment: Codable {
        let commitmentId: String
        
        private enum CodingKeys: String, CodingKey {
            case commitmentId = "commitment_id"
        }
    }
}
