//
//  Document.swift
//  
//
//  Created by Kayla Hoyet on 7/20/21.
//

import Foundation

public struct HumanIdentityDocument: Codable {
    
    internal static let path = "/human/identity-document"
    
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
    
    public static func create(
        humanId: String,
        idDocumentType: IdentityDocumentType.RawValue,
        idDocumentIdentifier: String,
        session: Session?,
        callback: @escaping (Error?, Self?) -> Void
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                humanId: humanId,
                idDocumentType: idDocumentType,
                idDocumentIdentifier: idDocumentIdentifier
            ),
            session: session,
            query: nil,
            method: .POST
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    private struct CreatePayload: Codable {
        let humanId: String
        let idDocumentType: IdentityDocumentType.RawValue
        let idDocumentIdentifier: String
        
        private enum CodingKeys: String, CodingKey {
            case humanId = "human_id"
            case idDocumentType = "id_document_type"
            case idDocumentIdentifier = "id_document_identifier"
        }
    }
}
