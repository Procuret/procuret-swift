//
//  Setup.swift
//  
//
//  Created by Kayla Hoyet on 8/4/21.
//

import Foundation

public struct Setup: Codable {
    
    internal static let path = "/setup"
    
    let publicId: Int
    let inviteeEntity: EntityHeadline?
    let invitorEntity: EntityHeadline
    let accepted: Bool
    let expectedDelivery: String
    let delivery: Bool
    let invoice: String
    let disposition: Disposition
    let description: String
    let value: String
    let created: String
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case inviteeEntity = "invitee_entity"
        case invitorEntity = "invitor_entity"
        case accepted
        case expectedDelivery = "expected_delivery"
        case delivery
        case invoice
        case disposition
        case description 
        case value
        case created
    }
}
    
