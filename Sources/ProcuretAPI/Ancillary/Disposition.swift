//
//  Disposition.swift
//  
//
//  Created by Kayla Hoyet on 7/20/21.
//

import Foundation

public struct Disposition: Codable {
    let count: Int
    let limit: Int
    let offset: Int
    let sequence: Int
    
    private enum CodingKeys: Int, CodingKey {
        case count
        case limit
        case offset
        case sequence
    }
}
