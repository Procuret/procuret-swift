//
//  Supplier.swift
//  
//
//  Created by Kayla Hoyet on 8/2/21.
//

import Foundation

public struct Supplier: Codable {
    
    internal static let path = "/supplier"
    
    let entity: Entity
    let authorised: Bool
    let brand: Brand?
    let disposition: Disposition
    let partnershipManager: HumanHeadline?
    
    private enum CodingKeys: String, CodingKey {
        case entity
        case authorised
        case brand
        case disposition
        case partnershipManager = "partnership_manager"
    }
    
    public static func create(
        legalName: String,
        tradingName: String?,
        phoneNumber: String,
        address: Address,
        callback: @escaping (Error?, Supplier?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(legalName: legalName,
                tradingName: tradingName, phoneNumber: phoneNumber,
                address: address),
            session: nil,
            query: nil,
            method: .POST
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let legalName: String
        let tradingName: String?
        let phoneNumber: String
        let address: Address
        
        private enum CodingKeys: String, CodingKey {
            case legalName = "legal_name"
            case tradingName = "trading_name"
            case phoneNumber = "phone_number"
            case address
        }
    }
}
