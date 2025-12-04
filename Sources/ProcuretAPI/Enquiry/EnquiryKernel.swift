//
//  EnquiryKernel.swift
//  
//
//  Created by Kayla Hoyet on 8/4/21.
//

import Foundation

public struct EnquiryKernel: Codable, Sendable {
    
    let enquiryId: Int
    let startTime: String
    let endTime: String?
    let endState: Int?
    let party: Int
    let type: Int
    let cachedReference: Int?
    let stackTrace: String?
    let rawResponse: String
    let rawRequest: String
    
    private enum CodingKeys: String, CodingKey {
        case enquiryId = "enquiry_id"
        case startTime = "start_time"
        case endTime = "end_time"
        case endState = "end_state"
        case party
        case type
        case cachedReference = "cached_reference"
        case stackTrace = "stack_trace"
        case rawResponse = "raw_response"
        case rawRequest = "raw_request"
    }
}
