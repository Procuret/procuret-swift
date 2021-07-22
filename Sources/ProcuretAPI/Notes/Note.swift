//
//  Note.swift
//  
//
//  Created by Kayla Hoyet on 7/22/21.
//

import Foundation

public struct Note: Codable {
    
    let publicId: String
    let author: HumanHeadline
    let created: ProcuretTime
    let body: String
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case author
        case created
        case body
    }
}
