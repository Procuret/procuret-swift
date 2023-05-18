//
//  Entity.swift
//  
//
//  Created by Kayla Hoyet on 7/21/21.
//  Modified by Hugh Jeremy on 25 Mar 2022
//

import Foundation

public struct Entity: Codable, Identifiable, Equatable, Hashable {
    
    internal static let path = "/entity"
    internal static let listPath = "/entity/list"
    
    public let publicId: Int
    public let publicIdShort: String
    public let identifierRecords: Array<EntityIdentifierRecord>
    public let legalEntityName: String
    public let tradingName: String?
    public let phoneNumber: PhoneNumber?
    public let address: Address?
    public let entityType: EntityType?
    public let created: Date?
    public let hasBusinessRecord: Bool?
    public let hasSupplierRecord: Bool?
    public let disposition: Disposition
    
    public var id: Int { get { return self.publicId } }
    public var isBusinessCustomer: Bool { get {
        return self.hasBusinessRecord ?? false
    } }
    public var offersProcuretAsSupplier: Bool { get {
        return self.hasSupplierRecord ?? false
    } }
    
    public var identifiers: Array<EntityIdentifier> { get {
        return self.identifierRecords.map { $0.asIdentifier }
    } }

    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case publicIdShort = "public_id_short" 
        case identifierRecords = "entity_identifiers"
        case legalEntityName = "legal_entity_name"
        case tradingName = "trading_name"
        case phoneNumber = "phone_number"
        case address = "business_address"
        case entityType = "entity_type_name"
        case created
        case hasBusinessRecord = "has_business_record"
        case hasSupplierRecord = "has_supplier_record"
        case disposition
    }
    
    public enum OrderBy: String {
        case name = "name"
        case created = "created"
        case modified = "modified"
    }
    
    public static func retrieve(
        authenticatedBy session: SessionRepresentative,
        withPublicId publicId: Int,
        at endpoint: ApiEndpoint = .live,
        then callback: @escaping (Error?, Entity?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            data: nil,
            session: session,
            query: QueryString([UrlParameter(publicId, key: "entity_id")]),
            method: .GET,
            endpoint: endpoint,
            then: { e, d in Request.decodeResponse(e, d, Self.self, callback) }
        )
        
        return
    
    }
    
    public static func create(
        identifier: EntityIdentifier,
        address: Address.CreationData,
        session: SessionRepresentative,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Entity?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                identifier: identifier.identifier,
                identifierType: identifier.identifierType,
                address: address
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) {
            error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    public static func setPermissions(
        entityId: Int,
        granteeAgentId: Int,
        read: Bool,
        write: Bool,
        manage: Bool,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Entity?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: SetPermissions(
                entityId: entityId,
                granteeAgentId: granteeAgentId,
                read: read,
                write: write,
                manage: manage
            ),
            session: nil,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let identifier: String
        let identifierType: EntityIdentifierType
        let address: Address.CreationData
        
        private enum CodingKeys: String, CodingKey {
            case identifier
            case identifierType = "identifier_type"
            case address
        }
    }
        
    private struct SetPermissions: Codable {
        let entityId: Int
        let granteeAgentId: Int
        let read: Bool
        let write: Bool
        let manage: Bool
        
        private enum CodingKeys: String, CodingKey {
            case entityId = "entity_id"
            case granteeAgentId = "agent_id"
            case read
            case write
            case manage
        }
    }

    public static func retrieveMany(
        session: SessionRepresentative,
        accessibleTo: Agent? = nil,
        nameFragment: String? = nil,
        limit: Int = 20,
        offset: Int = 0,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = Self.OrderBy.created,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Array<Entity>?) -> Void
    ) -> Void {
        
        typealias UP = UrlParameter
        
        Request.make(
            path: Self.listPath,
            data: nil,
            session: session,
            query: QueryString(targetsOnly: [
                UP(orderBy.rawValue, key: "order_by"),
                UP(order.rawValue, key: "order"),
                UP(limit, key: "limit"),
                UP(offset, key: "offset"),
                UP.optionally(accessibleTo?.agentId, key: "accessible_to"),
                UP.optionally(nameFragment, key: "name_fragment")
            ].compactMap{ $0 }),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
            return
            
            }
        
            return

    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.publicId)
        hasher.combine(self.hasBusinessRecord)
        hasher.combine(self.hasSupplierRecord)
        hasher.combine(self.address)
        hasher.combine(self.entityType)
        hasher.combine(self.identifierRecords)
        hasher.combine(self.legalEntityName)
    }

}
