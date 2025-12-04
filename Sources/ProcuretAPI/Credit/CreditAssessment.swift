//
//  CreditAssessment.swift
//  
//
//  Created by Kayla Hoyet on 8/5/21.
//

import Foundation

public struct CreditAssessment: Codable, Sendable {
    
    internal static let path = "/assessment/credit"
    internal static let listPath = CreditAssessment.path + "/list"
    
    let setupId: String
    let transactingHumanId: Int
    let model: Int
    let kernel: AssessmentKernel
    let disposition: Disposition
    
    private enum CodingKeys: String, CodingKey {
        case setupId = "setup_id"
        case transactingHumanId = "transacting_human_id"
        case model
        case kernel
        case disposition
    }
    
    public static func create(
        setupCode: String,
        transactingHumanId: String,
        creditModel: CreditModel,
        forceFresh: Bool,
        forcePositive: Bool,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                setupCode: setupCode,
                transactingHumanId: transactingHumanId,
                creditModel: creditModel,
                forceFresh: forceFresh,
                forcePositive: forcePositive
            ),
            session: nil,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    public static func retrieve(
        assessmentId: Int,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @Sendable @escaping (Error?, CreditAssessment?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: RetrieveParameters(assessmentId: assessmentId),
            session: session,
            query: nil,
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable, Sendable {
        let setupCode: String
        let transactingHumanId: String
        let creditModel: CreditModel
        let forceFresh: Bool
        let forcePositive: Bool
        
        private enum CodingKeys: String, CodingKey {
            case setupCode = "setup_code"
            case transactingHumanId = "transacting_human_id"
            case creditModel = "credit_Model"
            case forceFresh = "force_fresh"
            case forcePositive = "force_positive"
        }
    }
    
    private struct RetrieveParameters: Codable, Sendable {
        let assessmentId: Int
        
        private enum CodingKeys: String, CodingKey {
            case assessmentId = "assessment_id"
        }
    }
}
