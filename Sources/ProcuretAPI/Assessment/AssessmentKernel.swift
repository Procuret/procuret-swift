//
//  AssessmentKernel.swift
//  
//
//  Created by Kayla Hoyet on 8/4/21.
//

import Foundation

public struct AssessmentKernel: Codable {
    
    let indexid: Int
    let began: ProcuretTime
    let ended: ProcuretTime
    let requestingAgentId: Int
    let relevantEnquiries: Array<EnquiryKernel>
    let failureNotes: Array<String>
    let notes: Array<String>
    let didPass: Bool
    let forcePositiveAssessment: Bool
    let errorReport: ErrorReport?
    
    private enum CodingKeys: String, CodingKey {
        
        case indexid
        case began
        case ended
        case requestingAgentId = "requesting_agent_id"
        case relevantEnquiries = "relevant_enquiries"
        case failureNotes = "failure_notes"
        case notes
        case didPass = "did_pass"
        case forcePositiveAssessment = "force_positive_assessment"
        case errorReport = "error_report"
    }
}
