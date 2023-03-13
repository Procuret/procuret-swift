//
//  PendingSeries.swift
//  
//
//  Created by Kayla Hoyet on 3/9/23.
//

import Foundation

public struct PendingSeries: Codable, Identifiable {
    
    internal static let path = "/payment-series/pending"
    internal static let listPath = PendingSeries.path + "/list"
    
    public let exchangeCore: ExchangeCore
    public let commitmentId: String
    public let awaitingIdentityAssessment: Bool?
    public let awaitingCreditAssessment: Bool?
    public let disposition: Disposition
    public let id = UUID()
    
    public enum CodingKeys: String, CodingKey {
        case exchangeCore = "exchange_core"
        case commitmentId = "commitment_id"
        case awaitingIdentityAssessment = "awaiting_identity_assessment"
        case awaitingCreditAssessment = "awaiting_credit_assessment"
        case disposition
    }
    
    public static func retrieveMany(
        
        limit: Int,
        offset: Int,
        supplierId: String?,
        businessId: String?,
        humanId: String?,
        awaitingIdentity: Bool?,
        awaitingCredit: Bool?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        session: SessionRepresentative,
        callback: @escaping (Error?, Array<Self>?) -> Void
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
                    UP.optionally(supplierId, key: "supplier_id"),
                    UP.optionally(businessId, key: "business_id"),
                    UP.optionally(humanId, key: "human_id"),
                    UP.optionally(awaitingIdentity,
                                  key: "awaiting_identity_assessment"),
                    UP.optionally(awaitingCredit,
                                  key: "awaiting_credit_assessment")
                ].compactMap { $0 }
            ),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
            return
        }
    }
}
