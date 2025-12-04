//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 27/3/2022.
//

import Foundation


public enum Custodian: Int, Codable, CaseIterable, Identifiable,
                       Sendable {
    
    case stripe = 1
    case procuret = 2
    
    public var id: Int { get { return self.rawValue } }

}
