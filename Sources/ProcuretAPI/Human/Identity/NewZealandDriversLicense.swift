//
//  File.swift
//  
//
//  Created by Hugh on 11/5/2023.
//

import Foundation


public struct NewZealandDriversLicense {
    
    internal static let path: String =
        "\(HumanIdentityDocument.path)/nz-license"
    
    public static func create(
        authenticatedBy session: SessionRepresentative,
        identifying human: Human,
        licenseNumber: String,
        versionNumber: String,
        at endpoint: ApiEndpoint = .live,
        then callback: @escaping (Error?) -> Void
    ) {
        
        Request.make(
            path: Self.path,
            payload: Self.CreatePayload(
                human_id: human.agentId,
                license_number: licenseNumber,
                version_number: versionNumber
            ),
            session: session,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, _ in callback(error) }

    }
    
    private struct CreatePayload: Encodable {
        
        let human_id: Int
        let license_number: String
        let version_number: String
        
    }
    
}
