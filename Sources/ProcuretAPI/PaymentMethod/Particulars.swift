//
//  Particulars.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct Particulars: Codable, Sendable {
    
    let endingIn: String
    let accountName: String
    let accountNumber: String?
    let accountBSB: String?
    
    public enum CodingKeys: String, CodingKey {
        case endingIn = "ending_in"
        case accountName = "account_name"
        case accountNumber = "account_number"
        case accountBSB = "bsb_code"
    }
}
