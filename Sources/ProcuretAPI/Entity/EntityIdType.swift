//
//  EntityIdType.swift
//  
//
//  Created by Kayla Hoyet on 7/22/21.
//  Modified by Hugh Jeremy on 26 Mar 2022
//

import Foundation


public enum EntityIdType: Int, Codable, CaseIterable, Identifiable {

    case abn = 1
    case acn = 2
    case nzbn = 3
    case nzcn = 4
    
    public var name: String { get {
        switch self {
        case .abn:
            return "Australian Business Number"
        case .acn:
            return "Australian Company Number"
        case .nzbn:
            return "New Zealand Business Number"
        case .nzcn:
            return "New Zealand Company Number"
        }
    } }
    
    public var abbreviation: String { get {
        switch self {
        case .abn:
            return "ABN"
        case .acn:
            return "ACN"
        case .nzbn:
            return "NZBN"
        case .nzcn:
            return "NZCN"
        }
    } }
    
    public var id: Int { get { return self.rawValue } }

}
