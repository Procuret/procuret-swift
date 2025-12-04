//
//  File.swift
//  
//
//  Created by Hugh on 23/11/2022.
//

import Foundation


public protocol SessionRepresentative: Sendable {
    
    var apiKey: String { get }
    var sessionId: Int { get }
    var perspective: Perspective { get }

    var agent: StandaloneAgent { get }
    var human: Human? { get }
    var agentId: Int { get }
    
    var userAgentPrefix: String? { get }

}
