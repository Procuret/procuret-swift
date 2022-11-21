//
//  ErrorReport.swift
//  
//
//  Created by Kayla Hoyet on 8/4/21.
//

import Foundation

public struct ErrorReport: Codable {
    
    internal static let path = "/error-report"
    internal static let listPath = ErrorReport.path + "/list"
    
    let indexid: Int
    let created: String //DateTime
    let applicationName: String
    let attributes: Array<ErrorInstanceLog>
    let disposition: Disposition
    
    private enum CodingKeys: String, CodingKey {
        case indexid
        case created
        case applicationName = "application_name"
        case attributes
        case disposition
    }
    
    public static func create(
        attributes: Array<ErrorAttribute>,
        endpoint: ApiEndpoint = ApiEndpoint.live
    ) {
        Request.make(
            path: self.path,
            payload: CreatePayload(
                attributes: attributes
            ),
            session: nil,
            query: nil,
            method: .POST,
            endpoint: endpoint
        ) { error, data in
            fatalError("Not implemented")
        }
    }
    
    private struct CreatePayload: Codable {
        let attributes: Array<ErrorAttribute>
        
        private enum CodingKeys: String, CodingKey {
            case attributes
        }
    }
}
