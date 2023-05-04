//
//  File.swift
//  
//
//  Created by Hugh on 4/5/2023.
//

import Foundation


public struct SupplierSale: Identifiable, Hashable, Codable {
    
    internal static let path = "/supplier-sale"
    internal static let listPath = SupplierSale.path + "/list"

    public let publicId: String
    public let created: Date
    public let supplier: EntityHeadline
    public let customer: EntityHeadline
    public let amount: Amount
    public let identifier: String
    public let disposition: Disposition
    
    public var id: String { get { return self.publicId } }

    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case created
        case supplier
        case customer
        case amount
        case identifier
        case disposition
    }
    
    public enum OrderBy: String, Encodable {
        case created = "created"
    }

    public static func retrieveMany(
        authenticatedBy session: SessionRepresentative,
        limit: Int = 20,
        offset: Int = 0,
        order: Order = .descending,
        orderBy: Self.OrderBy = .created,
        anyTextFragment: String? = nil,
        business: Business? = nil,
        supplier: Supplier? = nil,
        method: PaymentMethod? = nil,
        at endpoint: ApiEndpoint = .live,
        then callback: @escaping (Error?, Array<SupplierSale>?) -> Void
    ) -> Void {
        
        typealias UP = UrlParameter
        
        Request.make(
            path: Self.listPath,
            data: nil,
            session: session,
            query: QueryString(targetsOnly: [
                UP(limit, key: "limit"),
                UP(offset, key: "offset"),
                UP(order, key: "order"),
                UP(orderBy, key: "order_by"),
                UP.optionally(anyTextFragment, key: "any_fragment"),
                UP.optionally(business?.entity.publicId, key: "business_id"),
                UP.optionally(supplier?.entity.publicId, key: "supplier_id"),
                UP.optionally(method?.publicId, key: "method_id")
            ].compactMap { $0 }),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
        }
        
        return

    }
    
    public static func == (lhs: SupplierSale, rhs: SupplierSale) -> Bool {
        return lhs.publicId == rhs.publicId
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(self.publicId)
    }
    
}
