//
//  Document.swift
//  
//
//  Created by Kayla Hoyet on 7/20/21.
//

import Foundation

public struct HumanIdentityDocument: Codable {
    
    internal static let path = "/human/identity-document"
    
    public let publicId: String
    public let documentType: Int
    public let documentIdentifier: String
    public let state: Int
    public let disposition: Disposition
    
    public enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case documentType = "document_type"
        case documentIdentifier = "document_identifier"
        case state
        case disposition
    }
    
    public static func create(
        humanId: Int,
        idDocumentType: IdentityDocumentType.RawValue,
        idDocumentIdentifier: String,
        session: SessionRepresentative?,
        endpoint: ApiEndpoint = ApiEndpoint.live,
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
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            Request.decodeResponse(error, data, Self.self, callback)
            return
        }
    }
    
    private struct CreatePayload: Codable {
        let humanId: Int
        let idDocumentType: IdentityDocumentType.RawValue
        let idDocumentIdentifier: String
        
        private enum CodingKeys: String, CodingKey {
            case humanId = "human_id"
            case idDocumentType = "id_document_type"
            case idDocumentIdentifier = "id_document_identifier"
        }
    }
}
