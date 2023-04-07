//
//  OutstandingBalanceGraph.swift
//  
//
//  Created by Hugh on 7/4/2023.
//

import Foundation


public struct OutstandingBalanceGraph: Decodable {
    
    public static let path = "/outstanding-balance-graph"
    
    public let raw_yValues: Array<String>
    public let xLabels: Array<Date>
    
    public var yValues: Array<Decimal> { get {
        return self.raw_yValues.map { return Decimal(string: $0) ?? 0 }
    } }
    
    private enum CodingKeys: String, CodingKey {
        case raw_yValues = "y_values"
        case xLabels = "x_labels"
    }
    
    public static func retrieve(
        authenticatedBy session: SessionRepresentative,
        describing business: Business,
        at endpoint: ApiEndpoint = .live,
        then callback: @escaping (Error?, Self?) -> Void
    ) {
        
        return Self.retrieve(
            authenticatedBy: session,
            describingBusinessWithId: business.entity.publicId,
            at: endpoint,
            then: callback
        )
        
    }
    
    public static func retrieve(
        authenticatedBy session: SessionRepresentative,
        describingBusinessWithId businessEntityId: Int,
        at endpoint: ApiEndpoint = .live,
        then callback: @escaping (Error?, Self?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString(targetsOnly: [UrlParameter(
                businessEntityId, key: "business_id"
            )]),
            method: .GET,
            endpoint: endpoint
        ) { e, d in
            Request.decodeResponse(e, d, Self.self, callback, false)
            return
        }
        
        return
        
    }

}
