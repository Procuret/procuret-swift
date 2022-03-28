//
//  Method.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation


public enum PaymentMethod: UnderpinnedByMethodKernel {
    
    internal static let path: String = "/payment/method"
    internal static let listPath: String = Self.path + "/list"
    
    public enum OrderBy: String {
        case created = "created"
    }
    
    private enum CodingKeys : String, CodingKey {
        case kernel = "kernel"
    }
    
    case bankAccount(BankAccount)
    case stripeCard(Card)
    case stripeBecs(BECSDirectDebit)
    
    public var kernel: PaymentMethodKernel {
        
        switch self {
        case .bankAccount(let bankAccount):
            return bankAccount.kernel
        case .stripeBecs(let stripeBecs):
            return stripeBecs.kernel
        case .stripeCard(let stripeCard):
            return stripeCard.kernel
        }
        
    }
    
    public var friendlyDescription: String { get {

        switch self {
        case .bankAccount(let bankAccount):
            return bankAccount.friendlyDescription
        case .stripeBecs(let stripeBecs):
            return stripeBecs.friendlyDescription
        case .stripeCard(let stripeCard):
            return stripeCard.friendlyDescription
        }

    } }
    
    public var endsIn: String { get {
        switch self {
        case .bankAccount(let bankAccount):
            return bankAccount.endsIn
        case .stripeCard(let stripeCard):
            return stripeCard.endsIn
        case .stripeBecs(let stripeBecs):
            return stripeBecs.endsIn
        }
    } }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        let kernelContainer = try decoder.singleValueContainer()
        
        let kernel = try container.decode(
            PaymentMethodKernel.self,
            forKey: .kernel
        )
        
        switch (kernel.custodian, kernel.instrument) {
        case (.procuret, .bankAccount):
            self = Self.bankAccount(
                try kernelContainer.decode(BankAccount.self)
            )
        case (.stripe, .card):
            self = Self.stripeCard(
                try kernelContainer.decode(Card.self)
            )
        case (.stripe, .bankAccount):
            self = Self.stripeBecs(
                try kernelContainer.decode(BECSDirectDebit.self)
            )
        default:
            throw ProcuretAPIError(
                .badResponse,
                message: "Unexpected PaymentMethodKernel custodian, instrument"
            )
        }
    }
    
    public static func retrieveMany(
        session: Session,
        limit: Int = 20,
        offset: Int = 0,
        order: Order = Order.descending,
        orderBy: Self.OrderBy = Self.OrderBy.created,
        entityId: String? = nil,
        authorityId: String? = nil,
        active: Bool? = nil,
        instrument: Instrument? = nil,
        processor: Processor? = nil,
        callback: @escaping (Error?, Array<PaymentMethod>?) -> Void
    ) {
        
        typealias UP = UrlParameter
        
        Request.make(
            path: PaymentMethod.listPath,
            data: nil,
            session: session,
            query: QueryString(
                targetsOnly: [
                    UP(limit, key: "limit"),
                    UP(offset, key: "offset"),
                    UP(order.rawValue, key: "descending"),
                    UP(orderBy.rawValue, key: "created"),
                    UP.optionally(entityId, key: "entity_id"),
                    UP.optionally(authorityId, key: "authority_id"),
                    UP.optionally(active, key: "active"),
                    UP.optionally(instrument, key: "instrument"),
                    UP.optionally(processor, key: "processor")
                ].compactMap { $0 }
            ),
            method: .GET
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
            return
        }
    }
    
    
}

struct GenericPaymentMethod: Decodable {
    let results: [PaymentMethod]
}

/*

public struct PaymentMethodX: Codable, Identifiable {
    
    internal static let path = "/payment/method"
    internal static let listPath = PaymentMethod.path + "/list"
    
    public enum OrderBy: String {
        case created = "created"
    }
    
    private enum CodingKeys: CodingKey {
        
    }
    
    public static func retrieveMany(
        limit: Int,
        offset: Int,
        order: Order,
        orderBy: PaymentMethod.OrderBy,
        entityId: String?,
        authorityId: String?,
        active: Bool?,
        instrument: Instrument?,
        processor: Processor?,
        session: Session?,
        callback: @escaping (Error?, Array<PaymentMethod>?) -> Void
    ) {
        Request.make(
            path: PaymentMethod.listPath,
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
*/
