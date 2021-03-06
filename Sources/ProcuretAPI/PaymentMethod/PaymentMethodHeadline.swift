//
//  PaymentMethodHeadline.swift
//  
//
//  Created by Kayla Hoyet on 7/29/21.
//

import Foundation

public struct PaymentMethodHeadline: Codable, IdentifiesPaymentMethod {
    
    public let publicId: String
    public let description: String
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case description
    }
    
    public var paymentMethodId: String { get { return self.publicId } }

}
