//
//  BusinessAgreement.swift
//  
//
//  Created by Kayla Hoyet on 8/4/21.
//

import Foundation

public struct BusinessAgreement: Codable {
    
    internal static let path = "/business/agreement"
    
    let businessId: String
    let signaturePNG: String
    
    private enum CodingKeys: String, CodingKey {
        case businessId = "business_id"
        case signaturePNG = "signature_base64PNG"
    }
}
