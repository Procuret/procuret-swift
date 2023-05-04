//
//  File.swift
//  
//
//  Created by Hugh on 4/5/2023.
//

import Foundation

public struct SupplierPayout: Codable, Hashable, Identifiable {
    
    static let path: String = "/supplier-payout"
    static let listPath: String = SupplierPayout.path + "/list"
    
    public let publicId: String
    public let created: Date
    public let executed: Date
    public let amount: Amount
    public let customer: EntityHeadline
    public let supplier: EntityHeadline
    public let destination: PaymentMethodHeadline
    public let relatedInvoiceIds: Array<String>
    public let disposition: Disposition
    
    public var id: String { get { return self.publicId } }
    
    private enum CodingKeys: String, CodingKey {
        
        case publicId = "public_id"
        case created
        case executed
        case amount
        case customer
        case supplier
        case destination
        case relatedInvoiceIds = "related_invoice_ids"
        case disposition
        
    }
    
    public enum OrderBy: String, Encodable {
        case executed = "executed"
        case created = "created"
    }
    
    public static func retrieveMany(
        authenticatedBy session: SessionRepresentative,
        limit: Int = 20,
        offset: Int = 0,
        order: Order = .descending,
        orderBy: OrderBy = .executed,
        anyTextFragment: String? = nil,
        publicId: String? = nil,
        supplier: Supplier? = nil,
        at endpoint: ApiEndpoint = .live,
        then callback: @escaping (Error?, Array<Self>?) -> Void
    ) -> Void {
        
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
                UP.optionally(anyTextFragment, key: "any_fragment"),
                UP.optionally(supplier?.entity.publicId, key: "supplier_id"),
                UP.optionally(publicId, key: "public_id")
            ].compactMap { $0 }),
            method: .GET,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Array<Self>.self, callback)
        }
        
        return
        
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(self.publicId)
    }

    public static func == (lhs: SupplierPayout, rhs: SupplierPayout) -> Bool {
        return lhs.publicId == rhs.publicId
    }
    
    
}
