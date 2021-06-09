//
//  Error.swift
//  
//
//  Created by Hugh Jeremy on 9/6/21.
//

import Foundation


public protocol ProcuretError: Identifiable, Error, CustomStringConvertible {
    
    var message: String { get }
    var technicalMessage: String? { get }
    
}

extension ProcuretError {
    
    public var description: String { get { return self.message } }
    public var technicalMessage: String? { get { return nil } }
    
}

