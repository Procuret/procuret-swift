//
//  CreationNote.swift
//  
//
//  Created by Kayla Hoyet on 7/22/21.
//

import Foundation

public struct CreationNote: Codable {
    
    let humanId: String
    let note: Note
    
    public enum CodingKeys: String, CodingKey {
        case humanId = "human_id"
        case note
    }
}
