//
//  File.swift
//  
//
//  Created by Hugh on 15/5/2023.
//

import Foundation


public struct IdentityDocumentHeadline: Codable, Identifiable {
    
    public let publicId: String
    public let documentType: IdentityDocumentType
    
    public var id: String { get { return self.publicId } }
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case documentType = "document_type"
    }

}
