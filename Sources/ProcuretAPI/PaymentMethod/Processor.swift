//
//  Processor.swift
//  
//
//  Created by Kayla Hoyet on 2/16/22.
//  Modified by Hugh Jeremy on 27 Mar 2022
//

import Foundation


public enum Processor: Int, Codable, CaseIterable, Identifiable {
    
    case stripe = 1
    case offPlatform = 2
    case zai = 4
    
    public var id: Int { get { return self.rawValue } }

}
