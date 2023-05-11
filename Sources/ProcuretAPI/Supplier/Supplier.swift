//
//  Supplier.swift
//  
//
//  Created by Kayla Hoyet on 8/2/21.
//

import Foundation

public struct Supplier: Codable, Identifiable, Equatable, Hashable {
    
    internal static let path = "/supplier"
    internal static let listPath = Supplier.path + "/list"
    internal static let entityPath = Supplier.path + "/from-entity"
    
    public let entity: Entity
    public let authorised: Bool
    public let brand: Brand?
    public let disposition: Disposition
    public let partnershipManager: HumanHeadline?
    public let offersPayNow: Bool
    public let payNowFeeMode: PayNowFeeMode
    public let maxTransactionSize: Array<Amount>
    public let termRates: Array<TermRate>
    public let defaultDenomination: Currency
    public let country: Country
    
    public var id: Int { return self.entity.publicId }

    public var friendlyName: String {
        return self.brand?.name ?? self.entity.legalEntityName
    }

    private enum CodingKeys: String, CodingKey {
        case entity
        case authorised
        case brand
        case disposition
        case partnershipManager = "partnership_manager"
        case offersPayNow = "offers_pay_now"
        case payNowFeeMode = "pay_now_fee_mode"
        case maxTransactionSize = "max_transaction_size"
        case termRates = "term_rates"
        case defaultDenomination = "default_denomination"
        case country
    }
    
    public static func create(
        legalName: String,
        tradingName: String?,
        phoneNumber: String,
        address: Address.CreationData,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
        callback: @escaping (Error?, Supplier?) -> Void
    ) {
        Request.make(
            path: "/supplier/raw",
            payload: CreatePayload(
                legalName: legalName,
                tradingName: tradingName,
                phoneNumber: phoneNumber,
                address: address
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
        }
    }
    
    public static func create(
        authenticatedBy session: SessionRepresentative,
        entity: Entity,
        at endpoint: ApiEndpoint,
        callback: @escaping (Error?, Supplier?) -> Void
    ) {
        
        Request.make(
            path: Self.entityPath,
            payload: CreateFromEntityPayload(entity_id: entity.publicId),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint,
            then: { error, data in
                Request.decodeResponse(error, data, Self.self, callback)
                return
            }
        )
        
        return

    }
    
    private struct CreateFromEntityPayload: Encodable {
        let entity_id: Int
    }
    
    public static func retrieve(
        forEntity entity: Entity,
        authenticatedBy session: SessionRepresentative? = nil,
        at endpoint: ApiEndpoint = ApiEndpoint.live,
        then callback: @escaping (Error?, Self?) -> Void
    ) {
        
        return Self.retrieve(
            supplierId: entity.publicId,
            authenticatedBy: session,
            at: endpoint,
            then: callback
        )
        
    }
    
    public static func retrieve(
        supplierId: Int,
        authenticatedBy session: SessionRepresentative? = nil,
        at endpoint: ApiEndpoint = ApiEndpoint.live,
        then callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [UrlParameter(supplierId, key: "supplier_id")]
                ),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    public enum OrderBy: String {
        
        case created = "created"
        case modified = "modified"
        case legalName = "legal_name"
        case brandName = "brand_name"
        case transactionCount = "transaction_count"
        case lastTransactiontime = "last_transaction_time"
        
    }
    
    public static func retrieveMany(
        authenticatedBy session: SessionRepresentative,
        limit: Int = 20,
        offset: Int = 0,
        order: Order = .descending,
        orderBy: Self.OrderBy = .legalName,
        withAnyNameIncludingCharacters anyNameFragment: String? = nil,
        accessibleToAgentWithId: Int? = nil,
        withLegalNameIncludingCharacters legalNameFragment: String? = nil,
        withBrandNameIncludingCharacters brandNameFragment: String? = nil,
        authorisedToTransact authorised: Bool? = nil,
        havingBrand withBrand: Bool? = nil,
        havingTransacted hasTransacted: Bool? = nil,
        withDefaultDenomination defaultDenomination: Currency? = nil,
        active: Bool? = nil,
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
                UP(order.rawValue, key: "order"),
                UP(orderBy.rawValue, key: "order_by"),
                UP.optionally(anyNameFragment, key: "any_name"),
                UP.optionally(accessibleToAgentWithId, key: "accessible_to"),
                UP.optionally(legalNameFragment, key: "legal_name"),
                UP.optionally(brandNameFragment, key: "brand_name"),
                UP.optionally(authorised, key: "authorised_to_transact"),
                UP.optionally(withBrand, key: "has_brand"),
                UP.optionally(hasTransacted, key: "has_transacted"),
                UP.optionally(
                    defaultDenomination?.indexid,
                    key: "default_denomination"
                ),
                UP.optionally(active, key: "active")
            ].compactMap { $0 }),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
            return
        }
        
        return
        
    }
    
    private struct CreatePayload: Codable {
        let legalName: String
        let tradingName: String?
        let phoneNumber: String
        let address: Address.CreationData
        
        private enum CodingKeys: String, CodingKey {
            case legalName = "legal_name"
            case tradingName = "trading_name"
            case phoneNumber = "phone_number"
            case address
        }
    }
    
    public static func == (lhs: Supplier, rhs: Supplier) -> Bool {
        return lhs.entity.publicId == rhs.entity.publicId
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.entity.publicId)
        return
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Self.CodingKeys)
        let c = container
        
        self.entity = try c.decode(Entity.self, forKey: .entity)
        self.authorised = try c.decode(Bool.self, forKey: .authorised)
        self.brand = try c.decode(Brand?.self, forKey: .brand)
        self.disposition = try c.decode(Disposition.self, forKey: .disposition)
        self.partnershipManager = try c.decode(
            HumanHeadline?.self,
            forKey: .partnershipManager
        )
        self.offersPayNow = try c.decode(Bool.self, forKey: .offersPayNow)
        self.payNowFeeMode = try c.decode(
            PayNowFeeMode.self,
            forKey: .payNowFeeMode
        )
        self.maxTransactionSize = try c.decode(
            Array<Amount>.self,
            forKey: .maxTransactionSize
        )
        self.termRates = try c.decode(Array<TermRate>.self, forKey: .termRates)

        self.country = try c.decode(Country.self, forKey: .country)
        
        /* The denomination might be an integer ID, or a decodable object*/
        let denomination: Currency
        
        do {
            let denominationId = try container.decode(
                Int.self,
                forKey: .defaultDenomination
            )
            guard let candidate = Currency.with(indexid: denominationId) else {
                throw ProcuretAPIError.init(.inconsistentState)
            }
            denomination = candidate
        } catch {
            
            denomination = try container.decode(
                Currency.self,
                forKey: .defaultDenomination
            )
            
        }
        
        self.defaultDenomination = denomination
        
        return

    }

}
