//
//  Document.swift
//  
//
//  Created by Kayla Hoyet on 7/20/21.
//

import Foundation

public struct HumanIdentityDocument: Codable {
    let documentTypeId: Int
    let documentName: String
    let documentIdentifier: String
    let stateID: Int
    let stateName: String
    
    public enum CodingKeys: String, CodingKey {
        case documentTypeId = "document_type_id"
        case documentName = "document_name"
        case documentIdentifier = "document_identifier"
        case stateID = "state_id"
        case stateName = "state_name"
    }
}
