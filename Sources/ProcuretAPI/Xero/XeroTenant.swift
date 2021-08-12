//
//  XeroTenant.swift
//  
//
//  Created by Kayla Hoyet on 8/12/21.
//

import Foundation

public struct XeroTenant: Codable {
    
    internal static let path = "/xero/tenant"
    
    let publicId: String
    let tenantId: String
    let tenantType: String
    let tenantName: String?
    
    private enum CodingKeys: String, CodingKey {
        case publicId = "public_id"
        case tenantId = "tenant_id"
        case tenantType = "tenant_type"
        case tenantName = "tenant_name"
    }
}
