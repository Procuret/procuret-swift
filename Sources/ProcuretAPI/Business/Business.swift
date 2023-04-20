//
//  Business.swift
//  
//
//  Created by Kayla Hoyet on 10/28/21.
//

import Foundation

public struct Business: Codable {
    
    internal static let path = "/business"
    internal static let listPath = Business.path + "/list"

    public let entity: Entity
    
    private enum CodingKeys: String, CodingKey {
        case entity
    }
    
    public enum OrderBy: String {
        case created = "created"
        case name = "name"
        case lastTransacted = "last_transaction_time"
        case transactionCount = "last_transaction_count"
    }
    
    public static func create(
        identifier: String,
        idType: EntityIdType,
        address: Address.CreationData,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Business?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                identifier: identifier,
                idType: idType,
                address: address
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
    
    public static func create(
        entity: Entity,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Business?) -> Void
    ) {

        Request.make(
            path: self.path,
            payload: CreateWithEntityPayload(entity_id: entity.publicId),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }

    }
    
    public static func retrieveMany(
        authenticatedBy session: SessionRepresentative,
        limit: Int = 20,
        offset: Int = 0,
        order: Order = .ascending,
        orderBy: Self.OrderBy = .created,
        anyFragment: String? = nil,
        accessibleTo accessibleToAgent: Agent? = nil,
        hasTransacted: Bool? = nil,
        hasTransactedWithSupplier: Supplier? = nil,
        at endpoint: ApiEndpoint = .live,
        then callback: @escaping (Error?, Array<Self>?) -> Void
    ) {
        
        typealias UP = UrlParameter
        
        Request.make(
            path: Self.listPath,
            data: nil,
            session: session,
            query: QueryString([
                UP(limit, key: "limit"),
                UP(offset, key: "offset"),
                UP(order, key: "order"),
                UP(orderBy, key: "order_by"),
                UP.optionally(anyFragment, key: "any_fragment"),
                UP.optionally(
                    accessibleToAgent?.agentId,
                    key: "accessible_to"
                ),
                UP.optionally(hasTransacted, key: "has_transacted"),
                UP.optionally(
                    hasTransactedWithSupplier?.entity.publicId,
                    key: "has_transacted_with"
                )
            ].compactMap { $0 }),
            method: .GET,
            endpoint: endpoint
        ) { e, d in
            Request.decodeResponse(e, d, Array<Self>.self, callback)
            return
        }
        
        return

    }
    
    private struct CreatePayload: Codable {
        let identifier: String
        let idType: EntityIdType
        let address: Address.CreationData
        
        private enum CodingKeys: String, CodingKey {
            case identifier
            case idType = "identifier_type"
            case address
        }
    }
    
    private struct CreateWithEntityPayload: Codable {
        let entity_id: Int
    }
    
}
