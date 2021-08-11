//
//  PaymentSequence.swift
//  
//
//  Created by Kayla Hoyet on 8/11/21.
//

import Foundation

public struct PaymentSequence: Codable {
    
    let publicId: String
    let slices: Array<SequenceSlice> 
}
